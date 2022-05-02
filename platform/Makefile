environment=dev

-include .env

tr_opt=
tr_state=-backend-config="key=infra"
tr_vars=

tr_cmd = AWS_PROFILE=$(aws_profile) terraform $(tr_opt)

workspace:
	$(tr_cmd) workspace new $(environment) || $(tr_cmd) workspace select $(environment) && echo "Switched to workspace/environment: $(environment)"

init:
	$(tr_cmd) init $(tr_state) $(tr_vars)

plan: workspace
	$(tr_cmd) plan

apply: workspace
	 $(tr_cmd) apply -auto-approve

destroy: workspace
	$(tr_cmd) destroy

