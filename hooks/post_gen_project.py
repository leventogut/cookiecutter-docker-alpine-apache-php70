from __future__ import print_function
import cookiecutter
from subprocess import call
import os
import random
import shutil

# Get the root project directory
PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)


def remove_procfile(project_directory):
    """Removes the mkdocs files and directory"""

    procfile_config_location = os.path.join(
        PROJECT_DIRECTORY,
        'Procfile'
    )
    if os.path.exists(procfile_config_location):
        os.remove(procfile_config_location)

if '{{ cookiecutter.create_procfile_for_development }}'.lower() == 'n':
    remove_procfile(PROJECT_DIRECTORY)
