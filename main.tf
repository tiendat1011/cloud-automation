provider "aws" {
  region     = "ap-southeast-2"
}

module "iam" {
  source = "./modules/iam"
  iam_user_name = "test"
}

module "vpc" {
  source = "./modules/vpc"
  access_key = module.iam.access_key_id
  secret_key = module.iam.secret_access_key
  vpc_cidr   = "10.0.0.0/16"
}

module "ec2" {
  source = "./modules/ec2"
  access_key = module.iam.access_key_id
  secret_key = module.iam.secret_access_key
  vpc_id     = module.vpc.aws_vpc_id
  subnet_1_id = module.vpc.subnet_1_id
  subnet_2_id = module.vpc.subnet_2_id
  ami         = "ami-076fe60835f136dc9"
  instance_type = "t2.micro"
  key_name      = "aws-key"  
  public_key_path = file("./ed25519.pub")
}

output "id" {
  value = module.iam.access_key_id
}

output "secret" {
  value = module.iam.secret_access_key
  sensitive = true
}