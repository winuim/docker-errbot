from errbot import BotPlugin, botcmd
from itertools import chain
import git
import os
import subprocess


class GitBot(BotPlugin):
    """Git plugin for Errbot"""
    CONFIG_TEMPLATE = {'GIT_WORKDIR': '/app/srv/git_work/'}

    def configure(self, configuration):
        if configuration is not None and configuration != {}:
            config = dict(
                chain(self.CONFIG_TEMPLATE.items(), configuration.items()))
        else:
            config = self.CONFIG_TEMPLATE
        super(GitBot, self).configure(config)

    def get_configuration_template(self):
        return self.CONFIG_TEMPLATE

    @botcmd(admin_only=True)
    def cmd(self, msg, args):
        """whoami"""
        try:
            command = 'whoami'
            if args:
                command = args.split(' ')
            cmd_call = subprocess.Popen(
                command, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
        except Exception as _err:
            return _err
        tags, _err = cmd_call.communicate()
        return_code = cmd_call.returncode
        return f"return_code={return_code}\n{command}\n{tags.decode('utf-8')}\n"
