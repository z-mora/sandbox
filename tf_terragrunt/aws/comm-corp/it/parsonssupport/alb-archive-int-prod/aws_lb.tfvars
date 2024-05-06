load_balancers = {
  "alb-archive-int-prod" = {
    certificates = {
      "archive.parsons.com"  = {}
      "benefits.parsons.com" = {}
      "pweb.parsons.com"     = {}
      "pwebteam.parsons.com" = {}
    }
    deletion_protection            = false
    alb_drop_invalid_header_fields = false
    external_tls_decryption        = false
    alb_fips                       = false
    internal                       = true
    listeners = {
      "listener-443" = {
        port             = 443
        protocol         = "HTTPS"
        target_group_key = "tg-port-443"
        default_cert_key = "archive.parsons.com"
        secondary_cert_keys = [
          "benefits.parsons.com",
          "pweb.parsons.com",
          "pwebteam.parsons.com"
        ]
        rules = {
          redirect_pwebteam_cor_DM685616InternalAuditDashboard = {
            priority = 5
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/DM685616InternalAuditDashboard"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/DM685616InternalAuditDashboard/*"]
              }
            }
          }
          redirect_pwebteam_cor_reports = {
            priority = 10
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/reports"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/reports/*"]
              }
            }
          }
          redirect_pwebteam_inf_GTR = {
            priority = 15
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/GTR"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/GTR/*"]
              }
            }
          }
          redirect_pwebteam_inf_INDCapitalProjects = {
            priority = 20
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/INDCapitalProjects"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/INDCapitalProjects/*"]
              }
            }
          }
          redirect_pwebteam_COR_mdcp = {
            priority = 25
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/mdcp"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/mdcp/*"]
              }
            }
          }
          redirect_pwebteam_COR_OssProjectControls = {
            priority = 30
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/OssProjectControls"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/OssProjectControls/*"]
              }
            }
          }
          redirect_pwebteam_COR_prismug = {
            priority = 35
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/prismug"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/prismug/*"]
              }
            }
          }
          redirect_pwebteam_cor_supplychain = {
            priority = 40
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/supplychain"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/supplychain/*"]
              }
            }
          }
          redirect_pwebteam_COR_treasury = {
            priority = 45
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/treasury"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/treasury/*"]
              }
            }
          }
          redirect_pwebteam_cor_UASDroneGovernanceBoard = {
            priority = 50
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/UASDroneGovernanceBoard"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/UASDroneGovernanceBoard/*"]
              }
            }
          }
          redirect_pwebteam_INF_bcbc = {
            priority = 55
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/inf_bcbc"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/bcbc/*"]
              }
            }
          }
          redirect_pwebteam_inf_BDKsignallingprogramme = {
            priority = 60
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/BDKsignallingprogramme"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/BDKsignallingprogramme/*"]
              }
            }
          }
          redirect_pwebteam_inf_CBTCvsERTMS = {
            priority = 65
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CBTCvsERTMS"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/CBTCvsERTMS/*"]
              }
            }
          }
          redirect_pwebteam_INF_CommVICMgmt = {
            priority = 70
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CommVICMgmt"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/CommVICMgmt/*"]
              }
            }
          }
          redirect_pwebteam_inf_DSVICIT = {
            priority = 75
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/DSVICIT"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/DSVICIT/*"]
              }
            }
          }
          redirect_pwebteam_inf_ESS_Front_Line_Support = {
            priority = 80
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ESS_Front_Line_Support"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/ESS_Front_Line_Support/*"]
              }
            }
          }
          redirect_pwebteam_inf_IndustrialCapitalProjects = {
            priority = 85
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/IndustrialCapitalProjects"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/IndustrialCapitalProjects/*"]
              }
            }
          }
          redirect_pwebteam_inf_IndustrialStrategy = {
            priority = 90
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/IndustrialStrategy"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/IndustrialStrategy/*"]
              }
            }
          }
          redirect_pwebteam_inf_LA2028 = {
            priority = 95
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/LA2028"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/LA2028/*"]
              }
            }
          }
          redirect_pwebteam_inf_LDEQ-EVIS = {
            priority = 100
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/LDEQ-EVIS"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/LDEQ-EVIS/*"]
              }
            }
          }
          redirect_pwebteam_inf_OTNstudyRFP = {
            priority = 105
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/OTNstudyRFP"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/OTNstudyRFP/*"]
              }
            }
          }
          redirect_pwebteam_inf_peachtree = {
            priority = 110
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/inf_peachtree"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/peachtree/*"]
              }
            }
          }
          redirect_pwebteam_inf_VICDevOps = {
            priority = 115
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/VICDevOps"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/VICDevOps/*"]
              }
            }
          }
          redirect_pwebteam_fed_sss = {
            priority = 120
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Mayhem"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/fed/sss/*"]
              }
            }
          }
          redirect_pwebteam_COR_iscore = {
            priority = 125
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/iscore"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/iscore/*"]
              }
            }
          }
          redirect_pwebteam_COR_nonqual = {
            priority = 130
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/nonqual"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/nonqual/*"]
              }
            }
          }
          redirect_pwebteam_COR_IS_Desk_Stand = {
            priority = 135
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/IS_Desk_Stand"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/IS_Desk_Stand/*"]
              }
            }
          }
          redirect_pwebteam_COR_SysDev = {
            priority = 140
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/SysDev"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/SysDev/*"]
              }
            }
          }
          redirect_pwebteam_inf_ATMSproposals = {
            priority = 145
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ATMSproposals"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/ATMSproposals/*"]
              }
            }
          }
          redirect_pwebteam_inf_CalVIS = {
            priority = 150
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CalVIS"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/CalVIS/*"]
              }
            }
          }
          redirect_pwebteam_inf_CAN_PCM = {
            priority = 155
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CAN_PCM"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/CAN_PCM/*"]
              }
            }
          }
          redirect_pwebteam_inf_Canadian_Centralized_Database = {
            priority = 160
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Canadian_Centralized_Database"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/Canadian_Centralized_Database/*"]
              }
            }
          }
          redirect_pwebteam_inf_CentralizedProposalRepository = {
            priority = 165
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CentralizedProposalRepository"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/CentralizedProposalRepository/*"]
              }
            }
          }
          redirect_pwebteam_inf_ESHARPValidations = {
            priority = 170
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ESHARPValidations"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/ESHARPValidations/*"]
              }
            }
          }
          redirect_pwebteam_inf_GDOT_STIMS_2019 = {
            priority = 175
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/GDOT_STIMS_2019"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/GDOT_STIMS_2019/*"]
              }
            }
          }
          redirect_pwebteam_inf_GHIB = {
            priority = 180
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/GHIBinternal"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/GHIB/*"]
              }
            }
          }
          redirect_pwebteam_inf_markhammunicipalclasseadenisonst = {
            priority = 185
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/markhammunicipalclasseadenisonst"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/markhammunicipalclasseadenisonst/*"]
              }
            }
          }
          redirect_pwebteam_inf_MobilitySolutionsEast = {
            priority = 190
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/MobilitySolutionsEast"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/MobilitySolutionsEast/*"]
              }
            }
          }
          redirect_pwebteam_inf_pcard = {
            priority = 195
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/pcard"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/pcard/*"]
              }
            }
          }
          redirect_pwebteam_inf_TexasVIC = {
            priority = 200
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/TexasVIC"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/TexasVIC/*"]
              }
            }
          }
          redirect_pwebteam_inf_Tunneling = {
            priority = 205
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Tunneling"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/Tunneling/*"]
              }
            }
          }
          redirect_pwebteam_cor_procurement-contracts = {
            priority = 210
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/procurement-contracts"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/procurement-contracts/*"]
              }
            }
          }
          redirect_pwebteam_COR_wf = {
            priority = 215
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/wf"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/wf/*"]
              }
            }
          }
          redirect_pwebteam_INF_rsrcs = {
            priority = 220
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/rsrcs"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/rsrcs/*"]
              }
            }
          }
          redirect_pwebteam_COR_ISSD = {
            priority = 225
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ISSD"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/ISSD/*"]
              }
            }
          }
          redirect_pwebteam_cor_parsonsbi = {
            priority = 230
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/parsonsbi"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/parsonsbi/*"]
              }
            }
          }
          redirect_pwebteam_COR_ProposalReview = {
            priority = 235
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ProposalReview"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/ProposalReview/*"]
              }
            }
          }
          redirect_pwebteam_cor_safety-canada = {
            priority = 240
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/SafetyHealthandEnvironment/safety-canada"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/safety-canada/*"]
              }
            }
          }
          redirect_pwebteam_INF_ceg = {
            priority = 245
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ceg"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/ceg/*"]
              }
            }
          }
          redirect_pwebteam_inf_rcs = {
            priority = 250
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/rcs"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/rcs/*"]
              }
            }
          }
          redirect_pwebteam_COR_ISAPPS = {
            priority = 255
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ISAPPS"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/ISAPPS/*"]
              }
            }
          }
          redirect_pwebteam_cor_quality_internal = {
            priority = 260
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/quality_internal"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/quality_internal/*"]
              }
            }
          }
          redirect_pwebteam_COR_pscapup = {
            priority = 265
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/pscapup"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/pscapup/*"]
              }
            }
          }
          redirect_pwebteam_cor_trade_compliance = {
            priority = 270
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/trade_compliance"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/trade_compliance/*"]
              }
            }
          }
          redirect_pwebteam_inf_deltek = {
            priority = 275
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/deltek"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/deltek/*"]
              }
            }
          }
          redirect_pwebteam_cor_communities = {
            priority = 280
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/communities"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/communities/*"]
              }
            }
          }
          redirect_pwebteam_cor_isbnsapp = {
            priority = 285
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/isbnsapp"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/isbnsapp/*"]
              }
            }
          }
          redirect_pwebteam_cor_ISChngMngmt = {
            priority = 290
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ISChngMngmt"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/ISChngMngmt/*"]
              }
            }
          }
          redirect_pwebteam_COR_IS-PM = {
            priority = 295
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/IS-PM"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/IS-PM/*"]
              }
            }
          }
          redirect_pwebteam_COR_isbussol = {
            priority = 300
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/isbussol"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/isbussol/*"]
              }
            }
          }
          redirect_pwebteam_COR_ess = {
            priority = 305
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Engineering_Systems"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/ess/*"]
              }
            }
          }
          redirect_pwebteam_inf_ptgbilling = {
            priority = 310
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ptgbilling"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/ptgbilling/*"]
              }
            }
          }
          redirect_pwebteam_inf_pei-bd = {
            priority = 315
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/pei-bd"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/pei-bd/*"]
              }
            }
          }
          redirect_pwebteam_INF_parcommfin = {
            priority = 320
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/parcommfin"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/parcommfin/*"]
              }
            }
          }
          redirect_pwebteam_INF_pgehydro = {
            priority = 325
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/pgehydro"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/pgehydro/*"]
              }
            }
          }
          redirect_pwebteam_INF_Photos = {
            priority = 330
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Photos"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/Photos/*"]
              }
            }
          }
          redirect_pwebteam_inf_Aviation_Qualifications = {
            priority = 335
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Aviation_Qualifications"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/Aviation_Qualifications/*"]
              }
            }
          }
          redirect_pwebteam_INF_BDArchive1 = {
            priority = 340
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/BDArchive1"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/BDArchive1/*"]
              }
            }
          }
          redirect_pwebteam_INF_BDArchive2 = {
            priority = 345
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/BDArchive2"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/BDArchive2/*"]
              }
            }
          }
          redirect_pwebteam_INF_billing = {
            priority = 350
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/billing"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/billing/*"]
              }
            }
          }
          redirect_pwebteam_cor_parsonsbi2 = {
            priority = 355
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/parsonsbi2"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/parsonsbi2/*"]
              }
            }
          }
          redirect_pwebteam_cor_FinanceAcctg = {
            priority = 360
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/FinanceAcctg"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/FinanceAcctg/*"]
              }
            }
          }
          redirect_pwebteam_cor_busops = {
            priority = 365
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/busops"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/busops/*"]
              }
            }
          }
          redirect_pwebteam_cor_CorporateTax = {
            priority = 370
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CorporateTax"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/CorporateTax/*"]
              }
            }
          }
          redirect_pwebteam_COR_ispmodocrpos = {
            priority = 375
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/ispmodocrpos"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/ispmodocrpos/*"]
              }
            }
          }
          redirect_pwebteam_COR_HRInfoPortal = {
            priority = 380
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/HRInfoPortal"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/HRInfoPortal/*"]
              }
            }
          }
          redirect_pwebteam_COR_infrastructure = {
            priority = 385
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/corpinfra"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/infrastructure/*"]
              }
            }
          }
          redirect_pwebteam_cor_archivephotos = {
            priority = 390
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/archivephotos"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/archivephotos/*"]
              }
            }
          }
          redirect_pwebteam_cnst_EVLWProposal = {
            priority = 395
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/EVLWProposal"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cnst/EVLWProposal/*"]
              }
            }
          }
          redirect_pwebteam_inf_Ontario2032 = {
            priority = 400
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Ontario2032"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/Ontario2032/*"]
              }
            }
          }
          redirect_pwebteam_INF_netdeploy = {
            priority = 405
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/netdeploy"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/netdeploy/*"]
              }
            }
          }
          redirect_pwebteam_INF_hist = {
            priority = 410
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/hist"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/hist/*"]
              }
            }
          }
          redirect_pwebteam_INF_FMM = {
            priority = 415
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/FMM"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/INF/FMM/*"]
              }
            }
          }
          redirect_pwebteam_inf_DBMinor_WellandRiverBridges = {
            priority = 420
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/DBMinor"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/DBMinor_WellandRiverBridges/*"]
              }
            }
          }
          redirect_pwebteam_cor_EntDataArch = {
            priority = 425
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/EntDataArch"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/cor/EntDataArch/*"]
              }
            }
          }
          redirect_pwebteam_COR_fap = {
            priority = 430
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/fap"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/COR/fap/*"]
              }
            }
          }
          redirect_pwebteam_inf_construct = {
            priority = 435
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/construct"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pwebteam.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/inf/construct/*"]
              }
            }
          }
          redirect_pweb_federal = {
            priority = 440
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/federal"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/federal/*"]
              }
            }
          }
          redirect_pweb_ops_facilities = {
            priority = 445
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/PWebFacilities/SitePages/CREF.aspx"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/facilities/*"]
              }
            }
          }
          redirect_pweb_corporate_onward = {
            priority = 450
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/onward"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/onward/*"]
              }
            }
          }
          redirect_pweb_corporate_marcom_brand = {
            priority = 455
            action = {
              type = "redirect"
              redirect = {
                host        = "brand.parsons.com"
                path        = "/"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/marcom/brand/*"]
              }
            }
          }
          redirect_pweb_ops_is_imaging_printing = {
            priority = 460
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/it/imaging_printing/SitePages/Imaging-Printing.aspx"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/is/imaging_printing/*"]
              }
            }
          }
          redirect_pweb_ops_is_mea_cellular = {
            priority = 465
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/it/mea_cellular/SitePages/MEA-Cellular.aspx"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/is/mea_cellular/*"]
              }
            }
          }
          redirect_pweb_ops_is_program_mgmt = {
            priority = 470
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/it/program_mgmt/SitePages/PMO.aspx"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/is/program_mgmt/*"]
              }
            }
          }
          redirect_pweb_benefits = {
            priority = 475
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/hr/benefits"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/benefits/*"]
              }
            }
          }
          redirect_pweb_corporate_drive = {
            priority = 480
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/hr/drive"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/drive/*"]
              }
            }
          }
          redirect_pweb_corporate_legal_trade-compliance = {
            priority = 485
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/legal/trade-compliance"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/legal/trade-compliance/*"]
              }
            }
          }
          redirect_pweb_corporate_hr_tm = {
            priority = 490
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/hr/tm"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/hr/tm/*"]
              }
            }
          }
          redirect_pweb_corporate_insurance = {
            priority = 495
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/CorporateInsurance"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/insurance/*"]
              }
            }
          }
          redirect_pweb_corporate_marcom = {
            priority = 500
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Communications/SitePages/EMG.aspx"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/corporate/marcom/*"]
              }
            }
          }
          redirect_pweb_infrastructure = {
            priority = 505
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/infrastructure"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/infrastructure/*"]
              }
            }
          }
          redirect_pweb_ops_Ethics = {
            priority = 510
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Ethics"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/Ethics/*"]
              }
            }
          }
          redirect_pweb_ops_facilities = {
            priority = 515
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/pwebfacilities"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/facilities/*"]
              }
            }
          }
          redirect_pweb_ops_sustainability = {
            priority = 520
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/sustainability"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/sustainability/*"]
              }
            }
          }
          redirect_pweb_travel = {
            priority = 525
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/Travel"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/travel/*"]
              }
            }
          }
          redirect_pweb_sites_inclusion-diversity = {
            priority = 530
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/hr/inclusion-diversity"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/sites/inclusion-diversity/*"]
              }
            }
          }
          redirect_pweb_ops_innovation = {
            priority = 535
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/sites/TechnologyCapabilities"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/ops/innovation/*"]
              }
            }
          }
          redirect_pweb_Pages = {
            priority = 540
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/Pages/*"]
              }
            }
          }
          redirect_pweb_ = {
            priority = 545
            action = {
              type = "redirect"
              redirect = {
                host        = "parsons365.sharepoint.com"
                path        = "/"
                port        = 443
                protocol    = "HTTPS"
                query       = "#{query}"
                status_code = "HTTP_301"
              }
            }
            conditions = {
              host_header_pweb = {
                host_header = ["pweb.parsons.com"]
              }
              path_federal = {
                path_pattern = ["/"]
              }
            }
          }
        }
        default_action = {
          type             = "forward"
          target_group_key = "tg-port-443"
        }
      }
    }
    redirect_80_to_443 = true
    subnet_ids         = ["subnet-9483babc", "subnet-ab23dcdc"]
    target_groups = {
      "tg-port-443" = {
        port                            = 443
        protocol                        = "HTTPS"
        targets                         = ["10.45.2.66", "10.45.1.244"]
        type                            = "ip"
        nlb_targets_outside_vpc         = false
        alb_target_for_port_80_listener = true
        health_check = {
          path     = "/"
          port     = 443
          protocol = "HTTPS"
        }
        stickiness = {
          type = "lb_cookie"
        }
      }
    }
    type   = "application"
    vpc_id = "vpc-59e9373c"
  }
}
