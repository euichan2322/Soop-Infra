locals {
  security_groups = {
    bastion = {
      name = "${var.project}-bastion-sg"
      ingress = [
        {
					description = "Allow ssh"
					from_port = 22
					to_port = 22
          protocol = "tcp"
					cidr_blocks = ["0.0.0.0/0"]
				}
      ]
    }

		alb = {
			name = "${var.project}-alb-sg"
			ingress = [
        {
          description = "Allow HTTP"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
				{
          description = "Allow HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ] 
		},

    front = {
      name    = "${var.project}-front-sg"
      ingress = [
        {
          description = "Allow HTTP"
          from_port   = 3000
          to_port     = 3000
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },

    back = {
      name    = "${var.project}-back-sg"
      ingress = [
        {
          description = "Allow HTTP"
          from_port   = 8080
          to_port     = 8080
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
		
		app = {
			name = "${var.project}-app-sg"
			ingress = [
        {
          description = "Allow HTTP"
          from_port   = 8082
          to_port     = 8082
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ] 
		},
    
    db = {
      name    = "${var.project}-db-sg"
      ingress = [
        {
          description = "Allow MySQL"
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/16"]
        }
      ]
    }
  }
}