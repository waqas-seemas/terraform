
terraform { 
  cloud { 
    
    organization = "damodaran-seemas-ai-org" 

    workspaces { 
      name = "seemas-prod" 
    } 
  } 
}