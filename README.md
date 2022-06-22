# 
Application repo:

https://github.com/andovnar2021/dna-project.git



<br>
<img src="https://github.com/andovnar2021/infra_flask_app/workflows/Terraform/badge.svg?branch=main">
<br>
<img src="https://github.com/andovnar2021/infra_flask_app/workflows/Terraform-prod/badge.svg?branch=main">
<br>
Infrastructure for flask application. PROD and DEV environment have the same structure. They can only be distinguished by the parameters specified in the corresponding files.
1. PIPELINE when creating pull request to main ->
- fmt and tfsec checks are performed
- rises DEV environment
- send notification message to slack
- 
2. Check DEV environment.

3.PIPELINE on merge to main->
- fmt and tfsec checks are performed
- rising PROD environment
- send notification message to slack
- 



