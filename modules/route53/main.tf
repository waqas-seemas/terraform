# resource "aws_route53_zone" "primary" {
#   name = "damodaran.seemas.ai."
#   tags = {
#     Environment = var.stage
#   }
# }

data "aws_route53_zone" "parent" {
  provider = aws.dns
  name     = "seemas.ai."
}

# # Use the zone we just created
# data "aws_route53_zone" "selected" {
#   name         = "damodaran.seemas.ai."
#   private_zone = false
#   depends_on   = [aws_route53_zone.primary]
# }

resource "aws_route53_record" "stage" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.stage == "prod" ? "" : "${var.stage}.damodaran"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
