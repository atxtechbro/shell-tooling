from setuptools import setup
from setuptools_rust import Binding, RustExtension

setup(
    name="grabout",
    version="0.1.0",
    rust_extensions=[RustExtension("grabout.grabout_rust", binding=Binding.PyO3)],
    packages=["grabout"],
    # rust extensions are not zip safe, just like C-extensions.
    zip_safe=False,
) 