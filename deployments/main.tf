resource "aws_instance" "Finance-Deploy" {
  ami           = "ami-0c768662cc797cd75" 
  instance_type = "t2.micro" 
  key_name = "harshit1"
  vpc_security_group_ids= ["sg-04184ed14f82d47b7"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./harshit1.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Finance Deploy"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.Finance-Deploy.public_ip} > inventory "
		}
  provisioner "local-exec" {
  command = " ansible-playbook /var/lib/jenkins/workspace/FinanceProject/deployments/financeplaybook.yml "
  } 
}
