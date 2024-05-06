properties([
  parameters([
    [$class: 'ChoiceParameter',
      choiceType: 'PT_CHECKBOX',
      description: 'Select the Application Service from the Dropdown List',
      filterLength: 1,
      filterable: false,
      name: 'data_center',
      script: [
        $class: 'GroovyScript',
        fallbackScript: [
          classpath: [],
          sandbox: false,
          script:
            "return['Could not get the services list']"
        ],
        script: [
          classpath: [],
          sandbox: false,
          script:
              "return['DC01', 'DC02', 'DC03']"
        ]
      ]
    ],
    [$class: 'DynamicReferenceParameter',
      choiceType: 'ET_FORMATTED_HTML',
      description: 'enter job params',
      name: 'hostname',
      referencedParameters: 'data_center',
      script:
        [$class: 'GroovyScript',
          fallbackScript: [
            classpath: [],
            sandbox: false,
            script: "return['']"
          ],
          script: [
            classpath: [],
            sandbox: false,
            script: '''
              if (data_center.contains('DC01')){
                  return """<textarea name=\"value\" rows=\"5\" class=\"setting-input   \"></textarea>"""
              } else
              if (data_center.contains('DC02')){
                  return """<textarea name=\"value\" rows=\"5\" class=\"setting-input   \"></textarea>"""
              }
              '''
          ]
        ],
      omitValueField: true
    ],
    [$class: 'DynamicReferenceParameter',
      choiceType: 'ET_FORMATTED_HTML',
      description: 'enter job params',
      name: 'ipaddress',
      referencedParameters: 'data_center',
      script:
        [$class: 'GroovyScript',
        fallbackScript: [
          classpath: [],
          sandbox: false,
          script: "return['']"
        ],
        script: [
          classpath: [],
          sandbox: false,
          script: '''
          if (data_center.contains('DC01')){
              return """<textarea name=\"value\" rows=\"5\" class=\"setting-input   \"></textarea>"""
          } else
          if (data_center.contains('DC02')){
              return """<textarea name=\"value\" rows=\"5\" class=\"setting-input   \"></textarea>"""
          }
          '''
        ]
      ],
      omitValueField: true
    ],
    [$class: 'DynamicReferenceParameter',
        choiceType: 'ET_FORMATTED_HTML',
        description: 'enter job params',
        name: 'port_number',
        referencedParameters: 'data_center',
        script:
          [$class: 'GroovyScript',
          fallbackScript: [
            classpath: [],
            sandbox: false,
            script: "return['']"
            ],
          script: [
            classpath: [],
            sandbox: false,
            script: '''
            if (data_center.contains('DC02')){
                return """<textarea name=\"value\" rows=\"5\" class=\"setting-input   \"></textarea>"""
            }
            '''
          ]
        ],
      omitValueField: true
    ]
  ])
])
pipeline {
  environment {
    vari = ""
  }
  agent any
  stages {
    stage ("Example") {
      steps {
        script{
          echo "${params.data_center}"
          echo '\n'
          echo "${params.hostname}"
          echo "${params.ipaddress}"
          echo "${params.port_number}"
        }
      }
    }
  }
}
