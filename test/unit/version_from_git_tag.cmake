cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

include(${CPM_PATH}/CPM.cmake)
include(${CPM_PATH}/testing.cmake)

cpm_get_version_from_git_tag("1.2.3" VERSION)
assert_equal("1.2.3" ${VERSION})

cpm_get_version_from_git_tag("v1.2.3" VERSION)
assert_equal("1.2.3" ${VERSION})

cpm_get_version_from_git_tag("1.2.3-a" VERSION)
assert_equal("1.2.3" ${VERSION})

cpm_get_version_from_git_tag("v1.2.3-a" VERSION)
assert_equal("1.2.3" ${VERSION})

# Full commit hash (40 chars) should return 0
cpm_get_version_from_git_tag("513039e3cba83284cec71287fd829865b9f423bc" VERSION)
assert_equal("0" ${VERSION})

# Short commit hash (7 chars) should also return 0
cpm_get_version_from_git_tag("513039e" VERSION)
assert_equal("0" ${VERSION})

# Medium commit hash (12 chars) should also return 0
cpm_get_version_from_git_tag("513039e3cba8" VERSION)
assert_equal("0" ${VERSION})

# Non-hash tags with numbers should still extract version
cpm_get_version_from_git_tag("release-2025" VERSION)
assert_equal("2025" ${VERSION})

# Non-hash tag with dashes (contains non-hex chars) should extract number
cpm_get_version_from_git_tag("asio-1-12-1" VERSION)
assert_equal("1" ${VERSION})
