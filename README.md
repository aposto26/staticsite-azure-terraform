# staticsite-azure-terraform
Deploying a static site on azure web services using terraform and pre-built landing page. 


Before deploying you will need to install both 'Azure CLI' and 'Terraform CLI' to your local path.

Within this repo you will find:
  - Terraform [main.tf]
  - index folder 
    - index.html
    - style.css
    - index.json
    - images
    
All of which can be edited to suit your needs. In order to make changes to the landing page you will need a basic understanding of html & css. 
This can be edited on the fly [temporarily] using *right click + Inspect*.

NOTE: Once you deploy the terraform code any changes to the index files will need to be uploaded directly to the storage conatiner '$web' on your Azure Account i.e running 'terraform apply' will not update the contents of the files themselves, only the file structure. 

Feel free to reach out @ https://www.linkedin.com/in/michael-aposto/ if you have any issues with this. There is loads of content that can support you but I am reachable if need be. 

You can now start building out your landing page for whatever purpose you desire. ENJOY!
