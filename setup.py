from setuptools import setup, find_packages

with open('README.md') as readme_file:
    README = readme_file.read()

setup_args = dict(
    name = 'podqueue',
    version = '0.1.2',
    description = 'Automate the archiving of podcast feeds, including show notes and images.',
    long_description_content_type = "text/markdown",
    long_description = README,
    license = 'MIT',
    packages = find_packages(),
    author = 'Tyler Quinlivan',
    author_email = 'hello@tylerquinlivan.com',
    keywords = ['podcast', 'podqueue', 'archive', 'download'],
    url = 'https://github.com/tquin/podqueue',
    download_url = 'https://pypi.org/project/podqueue/',
    include_package_data = True
)

install_requires = [
    'feedparser>=6.0.8',
    'requests>=2.22.0'
]

if __name__ == '__main__':
    setup(**setup_args, install_requires=install_requires)
