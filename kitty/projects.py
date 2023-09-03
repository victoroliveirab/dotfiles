import os
import sys

from kittens.tui.handler import result_handler


def main(_args):
    os.system("find $HOME -maxdepth 3 -name .git 2>&1 | fzf")
    return sys.stdin.read()
    # os.system("cd {}".format(output))


@result_handler(type_of_input="output")
def handle_result(args, output, target_window_id, boss):
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        command = "cd {}".format(output)
        # with open("a.txt", "w") as f:
        #     f.write(command)
        #     f.write("\n")
        #     f.write(output)
        os.system(command)
        # w.paste_text(command)
        # boss.call_remote_control(w, ("send-text", output))
