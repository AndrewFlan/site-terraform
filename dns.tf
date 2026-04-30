data "aws_route53_zone" "this" {
  name         = var.domain_name
  private_zone = false
}

# domain > Elastic IP
resource "aws_route53_record" "root" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [aws_eip.web.public_ip]
}

# www domain > Elastic IP
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.web.public_ip]
}
