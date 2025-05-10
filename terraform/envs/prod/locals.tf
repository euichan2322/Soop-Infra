locals {
	tg = {
		front = {
			name = "${var.project}-${var.env}-front-tg"
			port = 3000
			protocol = "HTTP"
			target_type = "ip"
		},
		back = {
			name = "${var.project}-${var.env}-back-tg"
			port = 8080
			protocol = "HTTP"
			target_type = "ip"
		}, 
		app = {
			name = "${var.project}-${var.env}-app-tg"
			port = 8082
			protocol = "HTTP"
			target_type = "ip"
		}
	}
}