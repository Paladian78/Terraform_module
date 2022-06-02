

module "virtual_machine" {
    source = "./modules/virtual_machines"
    # create_reource_group = false
    prefix="myfrst"
    location="eastasia"
    resource_group_name="myfrst-resources"
}

module "app_service" {
    source = "./modules/app_service"
    # create_reource_group = false
    prefix="myfrst"
    location= "eastasia"
    resource_group_name= "myfrst-resources"
}
  
