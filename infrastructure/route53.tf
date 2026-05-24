resource "aws_route53_record" "blog" {
  zone_id = data.terraform_remote_state.core.outputs.route53_imichka_zone_id
  name    = var.website_domain
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.website.domain_name]
}
