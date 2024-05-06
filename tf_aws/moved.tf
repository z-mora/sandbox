moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["r-gvmm-restrict_lambda_vpc_use"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.root["Root=restrict_lambda_vpc_use"]
}

moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-1uooggpp-network_account"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Infrastructure:NetworkProd=network_account"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-2oi7kzmc-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Sandbox=restrict_regions"]
}

moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-2oi7kzmc-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Sandbox=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-2oi7kzmc-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Sandbox=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-7h3aubq3-network_account"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Infrastructure=network_account"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ew5lilml-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Security=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ew5lilml-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Security=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ew5lilml-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Security=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-jkqbmqmw-network_account"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Infrastructure:NetworkTest=network_account"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-qsw1zn8t-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Infrastructure=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-qsw1zn8t-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Infrastructure=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-qsw1zn8t-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Infrastructure=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-sjru06lv-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Sandbox=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-sjru06lv-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Sandbox=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-sjru06lv-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Sandbox=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywvcr1wq-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Security=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywvcr1wq-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Security=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywvcr1wq-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Security=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywz8xr52-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Workload=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywz8xr52-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Workload=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-ywz8xr52-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:PolicyStaging:Workload=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-zzhjiotl-restrict_regions"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Workload=restrict_regions"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-zzhjiotl-restrict_root"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Workload=restrict_root"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["ou-gvmm-zzhjiotl-security_services_baseline"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.all["Root:Workload=security_services_baseline"]
}
moved {
  from = module.aws_organization[0].aws_organizations_policy_attachment.this["r-gvmm-organizations_restrict"]
  to   = module.aws_organization[0].aws_organizations_policy_attachment.root["Root=organizations_restrict"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["MEA:SDLC:Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Workload:SDLC:MEA"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["ca-central-1:Prod:Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Workload:Prod:ca-central-1"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["MEA:Prod:Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Workload:Prod:MEA"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["MEA:Prod:Security"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Security:Prod:MEA"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["ca-central-1:NetworkProd:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Infrastructure:NetworkProd:ca-central-1"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["MEA:NetworkProd:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Infrastructure:NetworkProd:MEA"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_3["MEA:Backup:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_4["Root:Infrastructure:Backup:MEA"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Workload:PolicyStaging"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:PolicyStaging:Workload"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Test:ServiceCatalog"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:ServiceCatalog:Test"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Test:Security"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Security:Test"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["SharedServicesTest:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Infrastructure:SharedServicesTest"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["SharedServicesProd:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Infrastructure:SharedServicesProd"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Security:PolicyStaging"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:PolicyStaging:Security"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Sandbox:PolicyStaging"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:PolicyStaging:Sandbox"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["SDLC:Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Workload:SDLC"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Prod:Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Workload:Prod"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Prod:ServiceCatalog"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:ServiceCatalog:Prod"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Prod:Security"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Security:Prod"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["NetworkTest:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Infrastructure:NetworkTest"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["NetworkProd:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Infrastructure:NetworkProd"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Infrastructure:PolicyStaging"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:PolicyStaging:Infrastructure"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["ExceptionAccounts:Exceptions"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Exceptions:ExceptionAccounts"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Dev:Sandbox"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Sandbox:Dev"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Demo:Sandbox"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Sandbox:Demo"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Backup:Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_3["Root:Infrastructure:Backup"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Workload"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Workload"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Suspended"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Suspended"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["ServiceCatalog"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:ServiceCatalog"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Security"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Security"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Sandbox"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Sandbox"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["PolicyStaging"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:PolicyStaging"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Infrastructure"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Infrastructure"]
}

moved {
  from = module.aws_organization[0].aws_organizations_organizational_unit.level_1["Exceptions"]
  to   = module.aws_organization[0].aws_organizations_organizational_unit.level_2["Root:Exceptions"]
}
