import re

from terminatorlib.config import Config
import terminatorlib.plugin as plugin

AVAILABLE = ["JiraUrlPlugin"]

CONFIG_DEFAULTS = {
    "match": "",
    "jira_url": "",
}


class JiraUrlPlugin(plugin.URLHandler):
    capabilties = ["url_handler"]
    handler_name = "jira_ticket"
    config = None
    plugin_name = "JiraUrlPlugin"

    def __init__(self):
        self.config = Config()

        if self.config.plugin_get_config(self.plugin_name) is None:
            for key, value in CONFIG_DEFAULTS.iteritems():
                self.config.plugin_set(self.plugin_name, key, value)
            self.config.save()

        self.match = self.config.plugin_get(self.plugin_name, "match")
        self.jira_url = self.config.plugin_get(self.plugin_name, "jira_url")


    def callback(self, url):
        if not (self.match or self.jira_url):
            return

        for item in re.findall(self.match, url):
            return("%s/%s" % (self.jira_url, item))
