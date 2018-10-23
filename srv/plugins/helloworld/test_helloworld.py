import helloworld

pytest_plugins = ["errbot.backends.test"]
extra_plugin_dir = '.'


def test_hello(testbot):
    testbot.push_message('!hello')
    assert 'Hello world!' in testbot.pop_message()


def test_hello_another(testbot):
    testbot.push_message('!hello another')
    assert 'HELLO WORLD!' in testbot.pop_message()


def test_hello_helper():
    expected = "Hello world!"
    result = helloworld.HelloWorld.hello_helper()
    assert result == expected


def test_hello_another_helper(testbot):
    plugin = testbot._bot.plugin_manager.get_plugin_obj_by_name('HelloWorld')
    expected = "HELLO WORLD!"
    result = plugin.hello_another_helper()
    assert result == expected
