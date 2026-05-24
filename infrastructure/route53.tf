resource "aws_route53_record" "blog" {
  zone_id = data.terraform_remote_state.core.outputs.route53_imichka_zone_id
  name    = "blog.imichka.me"
  type    = "CNAME"
  ttl     = 300
  records = ["d102lsq202hk7a.cloudfront.net"]
}
