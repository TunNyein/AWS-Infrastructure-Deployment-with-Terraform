locals {
  aws_vpcs = {

    sg_vpc1 = {
        vpc_cidr_block = "10.10.0.0/16"
        tags = { Name= "sg-vpc1", env= "Prod" }     
    }


    tk_vpc1 = {
         vpc_cidr_block = "10.20.0.0/16"
        tags = { Name= "tk-vpc1", env= "Dev" }
    }
    
  }

  aws_subnets = {
    sg_public_01  = { 
        vpc_key    = "sg_vpc1",
        cidr_block = "10.10.1.0/24",
        az         = "ap-southeast-1a" }
    sg_private_01 = { vpc_key = "sg_vpc1", cidr_block = "10.10.2.0/24", az = "ap-southeast-1b" }
    tk_public_01  = { vpc_key = "tk_vpc1", cidr_block = "10.20.1.0/24", az = "ap-southeast-1a" }
    tk_private_01 = { vpc_key = "tk_vpc1", cidr_block = "10.20.2.0/24", az = "ap-southeast-1b" }
  }

  aws_rtbs = {
    sg_private_rtb01 = {vpc_key = "sg_vpc1"}
    sg_public_rtb01  = {vpc_key = "sg_vpc1"}
    tk_private_rtb01 = {vpc_key = "tk_vpc1"}
    tk_public_rtb01  = {vpc_key = "tk_vpc1"}
  }

  rtb_associations = {
    
    sg-public-1-to-rtb-pub-01      = {subnet_id = "sg_public_01", rtb_id = "sg_public_rtb01"}
    

    sg-private-1-to-rtb-priv-01     =  {subnet_id = "sg_private_01", rtb_id = "sg_private_rtb01"}
    

    tk-public-1-to-rtb-pub-01      =  {subnet_id = "tk_public_01", rtb_id = "tk_public_rtb01"}


    tk-private-1-to-rtb-priv-01     =  {subnet_id = "tk_private_01", rtb_id = "tk_private_rtb01"}

  }

  igws= {
    sg_internet_gateway = {vpc_key="sg_vpc1" }
    tk_internet_gateway = {vpc_key="tk_vpc1" }
  }

  igw_attach = {
     sg_vpc_to_igw = {vpc_key="sg_vpc1", igw_id="sg_internet_gateway"}
     tk_vpc_to_igw = {vpc_key="tk_vpc1", igw_id="tk_internet_gateway"}

  }

  route_igw = {
    sg_public_01_to_sg_igw = {rtb_id="sg_public_rtb01", igw_id="sg_internet_gateway", des_cidr_block="0.0.0.0/0"}
    tk_public_01_to_tk_igw = {rtb_id="tk_public_rtb01", igw_id="tk_internet_gateway", des_cidr_block="0.0.0.0/0"}
  }


   sshs= {
    sg-ssh_pair = {algorithm = "RSA", rsa_bits  = 4096}
    tk-ssh_pair = {algorithm = "RSA", rsa_bits  = 4096}
   }

   key_pairs = {
     
     sg_key_pair = {key_name   = "sg_key_pair", public_key = "sg-ssh_pair"}
     tk_key_pair = {key_name   = "tk_key_pair", public_key = "tk-ssh_pair"}

   }

   private_keys = {
     sg_private_key = {content = "sg-ssh_pair", filename = "sg_private_key" }
     tk_private_key = {content = "tk-ssh_pair", filename = "tk_private_key" }
   }

   instances_id = {
        
        sg_ec2_01 = {ami = "ami-08908d9e195550170", instance_type = "t2.micro", subnet_id = "sg_public_01", key_name ="sg_key_pair"}
        tk_ec2_01 = {ami = "ami-08908d9e195550170", instance_type = "t2.micro", subnet_id = "tk_public_01", key_name ="tk_key_pair"}
 }
        

}


   


        