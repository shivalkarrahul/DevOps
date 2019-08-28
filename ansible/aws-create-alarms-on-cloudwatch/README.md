Note: Before executing the playbook, make susre that you are connected with the required AWS Account


* To create Alarms:

1. alarm-defination.yml: contains alarm defination, this task is called in create-alarm.yml. More metric definations can be added in this yml file.
2. create-alarm.yml: This playbook calls alarm-defination.yml

Define the following in create-alarm.yml to create alarms on EC2 instances

  vars:
    app_name: GiveSuffixToBeAddedToTheAlarm
    region: SpecifyARegionOfInstances
        alarm_recipients: SpecifyARNOfSNSTopic
  tasks:
  - include_tasks: alarm-defination.yml
    with_items:
      - GiveInstanceID1
      - GiveInstanceID2
      - GiveInstanceIDn

* Ansible Command to the run the playbook:
ansible-playbook create-alarm.yml
