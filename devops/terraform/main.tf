provider "aws" {
  profile    = "default"
  region     = "eu-west-2"
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "aws_key_pair" "deployer_my_site" {
  key_name   = "deployer_key_my_site"
  public_key = var.public_key
}

resource "aws_security_group" "ssh_my_site" {
  name = "ssh_my_site"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "http_my_site" {
  name = "http_my_site"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "https_my_site" {
  name = "https_my_site"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "my_site" {
  ami                    = "ami-0917237b4e71c5759"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer_my_site.key_name
  tags                   = {
    Name = "my_site",
  }
  vpc_security_group_ids = [
    aws_security_group.ssh_my_site.id,
    aws_security_group.http_my_site.id,
    aws_security_group.https_my_site.id,
  ]
}

resource "aws_eip" "my_site" {
    vpc      = true
    instance = aws_instance.my_site.id
}

output "server_public_ip" {
  value = aws_eip.my_site.public_ip
}

resource "cloudflare_record" "my_site" {
  zone_id = var.cloudflare_zone_id
  name    = "royhanley.com"
  value   = aws_eip.my_site.public_ip
  type    = "A"
}
