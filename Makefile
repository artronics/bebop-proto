.SILENT:

-include .env

tf_opt=-chdir=terraform
tf_state=-backend-config="key=proxy"
tf_vars=
apigee_auth = APIGEE_ACCESS_TOKEN=$(apigee_access_token) APIGEE_ORGANIZATION=$(apigee_organization)

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

aws-login:
	# TODO: aws_profile here is different from terraform
	bebop aws login --profile $(aws_profile) -a 347250048819 -u $(aws_user) --out-profile default -m $(m)

apigee-login:
	bebop apigee login --username $(apigee_user)
