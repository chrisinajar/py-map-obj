
from setuptools import setup
from pypandoc import convert_file

#: Converts the Markdown README in the RST format that PyPi expects.
long_description = convert_file('README.md', 'rst')

setup(name='map_object',
      description='A method for mapping dict objects as if it were an array',
      long_description=long_description,
      version='1.1.1',
      url='https://github.com/chrisinajar/py-map-obj',
      author='Chris Vickery',
      author_email='chrisinajar@gmail.com',
      license='MIT',
      # classifiers=[
      #     'Development Status :: 4 - Beta',
      #     'Intended Audience :: System Administrators',
      #     'License :: OSI Approved :: Apache Software License',
      #     'Programming Language :: Python :: 3'
      # ],
      packages=['map_object'],
      install_requires=[
          'six>=1.10'
      ]
    )
