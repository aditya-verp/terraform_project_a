resource "aws_instance" "web_instance" {
    ami           = var.web_ami
    instance_type = var.instance_type
    subnet_id     = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = <<-EOF
    #!/bin/bash
    echo "${tls_private_key.bastion_key.public_key_openssh}" >> /home/ubuntu/.ssh/authorized_keys
    chmod 600 /home/ubuntu/.ssh/authorized_keys
    ping -c 4 8.8.8.8 > /home/ubuntu/ping
    EOF

    tags = {
      Name   = "MyWebServer"
      Partof = "TaskProject"
    }
  }

resource "aws_instance" "db_instance" {
    ami           = var.db_ami
    instance_type = var.instance_type
    subnet_id     = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.db_sg.id]

    user_data = <<-EOF
    #!/bin/bash
    echo "${tls_private_key.bastion_key.public_key_openssh}" >> /home/ubuntu/.ssh/authorized_keys
    chmod 600 /home/ubuntu/.ssh/authorized_keys
    EOF

    tags = {
      Name   = "MyDatabaseServer"
      Partof = "TaskProject"
    }
  }

resource "aws_instance" "bastion_host" {
    ami           = var.bastion_ami
    instance_type = var.instance_type
    subnet_id     = aws_subnet.public_subnet.id
    key_name      = aws_key_pair.bastion.key_name

    vpc_security_group_ids = [aws_security_group.bastion_sg.id]

    user_data = <<-EOF
    #!/bin/bash
    echo "${tls_private_key.bastion_key.private_key_pem}" >> /home/ubuntu/id_rsa.pem
    # Update and install Python3 and Ansible-core
    apt-get update -y
    apt-get install -y python3 python3-pip
    apt-get install -y ansible-core net-tools vi
    EOF

    tags = {
      Name   = "BastionHost"
      Partof = "TaskProject"
    }
  }



output "web_instance_id" {
 value = aws_instance.web_instance.id
}

output "db_instance_id" {
 value = aws_instance.db_instance.id
}

output "bastion_host_id" {
  value = aws_instance.bastion_host.id
}