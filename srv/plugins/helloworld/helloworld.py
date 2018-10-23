from errbot import BotPlugin, botcmd
import ptvsd


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

    @staticmethod
    def hello_helper():
        return "Hello world!"

    def hello_another_helper(self):
        return "HELLO WORLD!"
