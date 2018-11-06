from errbot import BotPlugin, botcmd, re_botcmd
from errbot.version import VERSION
import ptvsd
import re
import subprocess


class HelloWorld(BotPlugin):
    """Example 'Hello, world!' plugin for Errbot"""

    @botcmd
    def hello(self, msg, args):
        """Say hello to the world"""
        if ptvsd.is_attached():
            print("Debug Start")
            ptvsd.break_into_debugger()
        return self.hello_helper()

    @botcmd
    def hello_another(self, msg, args):
        """Say hello to the world"""
        if ptvsd.is_attached():
            print("Debug Start")
            ptvsd.break_into_debugger()
        return self.hello_another_helper()

    @re_botcmd(pattern=r"^(([Cc]an|[Mm]ay) I have a )?cookie please\?$")
    def hand_out_cookies(self, msg, match):
        """
        Gives cookies to people who ask me nicely.

        This command works especially nice if you have the following in
        your `config.py`:

        BOT_ALT_PREFIXES = ('Err',)
        BOT_ALT_PREFIX_SEPARATORS = (':', ',', ';')

        People are then able to say one of the following:

        Err, can I have a cookie please?
        Err: May I have a cookie please?
        Err; cookie please?
        """
        yield "Here's a cookie for you, {}".format(msg.frm)
        yield "/me hands out a cookie."

    @re_botcmd(
        pattern=r"(^| )cookies?( |$)", prefixed=False, flags=re.IGNORECASE)
    def listen_for_talk_of_cookies(self, msg, match):
        """Talk of cookies gives Errbot a craving..."""
        return "Somebody mentioned cookies? Om nom nom!"

    @botcmd
    def git(self, msg, args):
        if ptvsd.is_attached():
            print("Debug Start")
            ptvsd.break_into_debugger()
        git_result = self.git_run(None, args)
        if git_result:
            return dict(git_run=f"{git_result.decode('utf-8')}")
        else:
            return {'version': VERSION}

    @staticmethod
    def hello_helper():
        return "Hello world!"

    def hello_another_helper(self):
        return "HELLO WORLD!"

    def git_run(self, cmd, *args):
        if isinstance(args[0], tuple):
            # Avoid duplicate tuple
            # ex. self.rev_parse("--show-toplevel")
            #   ->('git', 'rev-parse', ('--show-toplevel',))
            command = ("git", cmd) + tuple([arg for arg in args[0]])
        else:
            command = ("git", cmd) + args

        try:
            git_call = subprocess.Popen(
                command, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
        except Exception as _err:
            return None
        tags, _err = git_call.communicate()
        return_code = git_call.returncode
        if return_code != 0:
            return None
        else:
            tags = tags.rstrip(b"\n")
            return tags.split(b"\n").pop(-1)
