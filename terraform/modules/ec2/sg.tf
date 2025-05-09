resource "aws_security_group" "front-sg" {
    name = "${var.project}-front-sg"
    description = "${var.project}-front-sg"
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project}-front-sg"
        project = var.project
        env = var.env
    }
}