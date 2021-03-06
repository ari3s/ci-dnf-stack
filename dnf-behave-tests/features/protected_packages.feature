Feature: Protected packages


Background: Use dnf-ci-fedora repository
  Given I use the repository "dnf-ci-fedora"
    And I execute dnf with args "install filesystem"
   Then the exit code is 0
    And Transaction is following
        | Action        | Package                               |
        | install       | filesystem-0:3.9-2.fc29.x86_64        |
        | install       | setup-0:2.12.1-1.fc29.noarch          |


@tier1
Scenario: Package protected via setopt cannot be removed
   When I execute dnf with args "remove filesystem --setopt=protected_packages=filesystem"
   Then the exit code is 1
    And Transaction is empty
    And stderr contains "Problem: The operation would result in removing the following protected packages: filesystem"


Scenario: Package with protected dependency via setopt cannot be removed
   When I execute dnf with args "remove filesystem --setopt=protected_packages=setup"
   Then the exit code is 1
    And Transaction is empty
    And stderr contains "Problem: The operation would result in removing the following protected packages: setup"


# TODO: make protected packages work in installroots first
#Scenario: Package protected via a configuration file cannot be removed
#  Given I create and substitute file "/etc/dnf/protected.d/filesystem.conf" with
#        """
#        filesystem
#        """
#   When I execute dnf with args "remove filesystem"
#   Then the exit code is 1
#    And Transaction is empty
#    And stderr contains "Problem: The operation would result in removing the following protected packages: filesystem"


# TODO: Removal of DNF itself
# - doesn't makes sense to test in installroot
# - a potentially destructive test
