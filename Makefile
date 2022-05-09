.SILENT:

-include .env

tf_opt=-chdir=terraform
tf_state=-backend-config="key=proxy"
tf_vars=
apigee_auth = APIGEE_ACCESS_TOKEN=$(apigee_access_token) APIGEE_ORGANIZATION=$(apigee_organization)
aws = AWS_SECRET_ACCESS_KEY=$(aws_secret_access_key) AWS_ACCESS_KEY_ID=$(aws_access_key_id)
tf_cmd = AWS_PROFILE=$(aws_profile) $(apigee_auth) $(tf_vars) terraform $(tf_opt)

workspace:
	$(tf_cmd) workspace new $(environment) || $(tf_cmd) workspace select $(environment) && echo "Switched to workspace/environment: $(environment)"

init:
	$(tf_cmd) init $(tf_state)

plan: workspace
	$(tf_cmd) plan

apply: workspace
	 $(tf_cmd) apply -auto-approve

destroy: workspace
	$(tf_cmd) destroy

tmp_data = "./project.yml"
tmp_out = "./terraform/build/template"
proxies_dir = "./proxies"

template-proxies:
	rm -rf $(tmp_out)
	mkdir -p $(tmp_out)
	bebop template --template $(proxies_dir) --out $(tmp_out)/proxies --var-file $(tmp_data)

aws-login:
	# TODO: aws_profile (jalal.hosseini1) here is different from terraform
	bebop aws login --profile jalal.hosseini1  -a 347250048819 -u $(aws_user) --out-profile default --mfa $(m)

apigee-login:
	bebop apigee login --username $(apigee_user)
