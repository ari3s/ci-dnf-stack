Feature: Autoremoval of unneeded packages

Scenario: Remove with --setopt=clean_requirements_on_remove=True
  Given I use the repository "dnf-ci-fedora"
    And I use the repository "dnf-ci-thirdparty"
    When I execute dnf with args "install abcde"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                           |
        | install       | abcde-0:2.9.2-1.fc29.noarch       |
        | install       | flac-0:1.3.2-8.fc29.x86_64        |
        | install       | wget-0:1.19.5-5.fc29.x86_64       |
        | install       | FlacBetterEncoder-0:1.0-1.x86_64  |
   When I execute dnf with args "remove abcde --setopt=clean_requirements_on_remove=True"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                           |
        | remove        | abcde-0:2.9.2-1.fc29.noarch       |
        | remove        | flac-0:1.3.2-8.fc29.x86_64        |
        | remove        | wget-0:1.19.5-5.fc29.x86_64       |
        | remove        | FlacBetterEncoder-0:1.0-1.x86_64  |

Scenario: Remove with --setopt=clean_requirements_on_remove=False
  Given I use the repository "dnf-ci-fedora"
    And I use the repository "dnf-ci-thirdparty"
    When I execute dnf with args "install abcde"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                           |
        | install       | abcde-0:2.9.2-1.fc29.noarch       |
        | install       | flac-0:1.3.2-8.fc29.x86_64        |
        | install       | wget-0:1.19.5-5.fc29.x86_64       |
        | install       | FlacBetterEncoder-0:1.0-1.x86_64  |
   When I execute dnf with args "remove abcde --setopt=clean_requirements_on_remove=False"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                           |
        | remove        | abcde-0:2.9.2-1.fc29.noarch       |

