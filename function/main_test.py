from main import create_dirs
import mock
import unittest


class TestFunction(unittest.TestCase):
    @mock.patch('main.os')

    def test_create_dir(self, mock_make_dirs, mock_exists):
        mock_exists.return_value = True

        ceate_dirs('/new_dir')

#        mock_make_dirs.assert_called_with('/new_dir')

if __name__ == '__main__':
    unittest.main()
