import argparse
import json
import subprocess
from ast import literal_eval
from collections import defaultdict
from pathlib import Path

parser = argparse.ArgumentParser(
    description="""Determines which Terragrunt modules need to be processed and returns
    them as a Groovy map string, organized into groups based on the Terragrunt
    dependency graph.

    First, the list of changed files are obtained via git diff, which includes each
    file's full path within the repo. The the file names are dropped to keep only the
    folder path, aka Terragrunt module or working directory. Any files in the root are
    ignored. Any of these folders that do not contain a `terragrunt.hcl` file,
    indicating that it is indeed a Terragrunt module, are also skipped. Then, each of
    the Terragrunt modules that remain are grouped according to the dependency tree that
    is provided by the command `terragrunt output-module-groups`."""
)
parser.add_argument(
    "-d",
    "--debug",
    help="Print debug info. Don't use from Jenkins, since it captures stdout.",
    action="store_true",
)
parser.add_argument(
    "is_pr",
    help="""Whether the git diff is for a PR or not. If it's a PR, then git diff
    compares HEAD to the point where branch diverged from main. If it's instead
    for a merge, it compares HEAD to the previous commit. This is not a boolean
    flag because Jenkins will always send a value, either true or false.""",
    choices=["true", "True", "false", "False"],
)
parser.add_argument(
    "raw_terragrunt_output_module_groups",
    help="The raw output from the command `terragrunt output-module-groups` (JSON format).",
    type=json.loads,  # Automatically convert JSON string to dict
)
args = parser.parse_args()

# Groovy booleans are lowercase, but Python's are capitalized
# In Python, a non-empty string will evaluate to True if you use bool().
# e.g., bool('false') = True which is why we use literal_eval() here
is_pr = literal_eval(args.is_pr.capitalize())

if is_pr:
    command = ["git", "diff", "origin/main...HEAD", "--name-only"]
else:
    command = ["git", "diff", "HEAD^", "HEAD", "--name-only"]

diff_files = subprocess.check_output(command, encoding="utf-8").strip().split("\n")

if args.debug:
    print(f"Git diff: {diff_files}")

flat_terragrunt_modules: set[Path] = set()  # Use a set to keep only unique
repo_root_absolute = Path(__file__).parent.parent
# Use a defaultdict so new keys (each module group) inits to an empty set
terragrunt_module_groups: defaultdict[str, list[str]] = defaultdict(list)

# Iterate over each file after converting it to a Path object
for file in [Path(f) for f in diff_files]:
    if file.match("*/*") is False:
        if args.debug:
            print(f"Skipping file in root of tf_terragrunt: {file}")
        continue
    folder = file.parent  # Relative Path of Terragrunt module in repo
    # Create absolute Path of the Terragrunt module's HCL file
    terragrunt_module = repo_root_absolute / folder / "terragrunt.hcl"
    if args.debug:
        print(
            f"Terragrunt module exists: {terragrunt_module.exists()} : {terragrunt_module}"
        )
    if terragrunt_module.exists():
        # Drop terragrunt.hcl & keep the absolute path of the Terragrunt module, because
        # `terragrunt output-module-groups` contains absolute paths
        flat_terragrunt_modules.add(terragrunt_module.parent)

if args.debug:
    print(
        f"Found {len(flat_terragrunt_modules)} Terragrunt modules: {flat_terragrunt_modules}"
    )
    print("Organizing Terragrunt modules into groups...")


def get_module_group(
    raw_terragrunt_output_module_groups: dict[str, list[str]], terragrunt_module: Path
) -> str:
    terragrunt_module_as_str = str(terragrunt_module)
    for module_group, module_list in raw_terragrunt_output_module_groups.items():
        if terragrunt_module_as_str in module_list:
            if args.debug:
                print(
                    f"Set module group {module_group} for module: {terragrunt_module}"
                )
            return module_group
    raise ValueError(
        f"No match was found for ${terragrunt_module} in Terragrunt's dependency graph"
    )


for module in flat_terragrunt_modules:
    module_group = get_module_group(args.raw_terragrunt_output_module_groups, module)
    # Convert to relative for use in Jenkins
    relative_module_path_as_str = str(module.relative_to(repo_root_absolute))
    if args.debug:
        print(f"Storing relative path: {relative_module_path_as_str}")
    terragrunt_module_groups[module_group].append(relative_module_path_as_str)

# Sort keys & convert back to normal dict so Jenkins will process the groups in order
module_groups_to_return: dict[str, list[str]] = dict(
    sorted(terragrunt_module_groups.items())
)

if args.debug:
    print(
        f"Found {len(module_groups_to_return.keys())} module groups: {module_groups_to_return}"
    )
# Adjust formatting for Groovy so this can be serialized into a map
print(json.dumps(module_groups_to_return).replace("{", "[").replace("}", "]"))
