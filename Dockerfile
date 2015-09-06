FROM quay.io/ukhomeofficedigital/docker-centos-base

ENV AWS_BUCKET bucket-name
ENV AWS_REGION eu-west-1
ENV AWS_ACCESS_KEY_ID myId
ENV AWS_SECRET_ACCESS_KEY MyKey

ENV GPG_UID "Allan Degnan <allan@adegnan.net>"
ENV GPG_PUBLIC_KEY "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1\n\
\n\
mQENBFWtCnwBCACnVhylQH37Mw8koeFPF12p4+IK5z3DixZKhoaTDRmt8D3DmnVp\n\
NTQo1KQIBa2LMNme4Qy+abrcw6K4pDvU+HkSjjiqkd2nkVdRK2hqaEfTbt7SGaxq\n\
79j4SLr2m7JQIdRyYCQi9U/EbWO3oITg2ese9OKvDj0QONybk/s9eoTT/cv7GS5v\n\
FdXccJELIMv2uJfu7mTYwT9YMOKLVG7QvdFfPMyUSP159wfcIr9/JTtOdRllnTge\n\
yJFWYVHAFGCor6dTXo+C3yaQf9iCd4IJ1X1XW34xygqbafDtoXSBtL4VBVak3bNV\n\
zz8Fyo85+0MAI8RUWHrcyiBEWPqIY71+HWzdABEBAAG0IEFsbGFuIERlZ25hbiA8\n\
YWxsYW5AYWRlZ25hbi5uZXQ+iQE4BBMBAgAiBQJVrQp8AhsDBgsJCAcDAgYVCAIJ\n\
CgsEFgIDAQIeAQIXgAAKCRBuJJjqVjrvdc95CACSnnVt6dSf27yriskqFQXJRFoq\n\
aqIAbG4UpDl94b7Q/F+zFh7/1iYX8SMbbdTZglAshP8AtqhA9NxODx8BZ0dlWm7l\n\
NuJL6eXzGFPKVbZTG02956iIEXCfEpdmR24a5Z/cgmVHaG+Z/0lYNPjnuC+dzyLP\n\
L2l/jh9MYGkqJXmUkrxBQRTXb8EzU3QpenMguqbJvx/09GTrYpm9YJJczA5RF4oJ\n\
nPTkzIWCvErv3boccUb8Eesg8WxG1AE8iFkObLbI6xBV9Q5yTowucEamPAd7MtX9\n\
PCZtL/AVmuNi4h8FfIaVk6CqijldUA7W+3Ez2D737r0Ijj2Qk8cEKCAjaYkruQEN\n\
BFWtCnwBCADSeZKe1N1HejHRwoZrNTl6y/ka1YS7BHx892CjFXNmJKjE7LJfEw2c\n\
N2H7JDuyQqoX5zY8rPd4NVZc7iMgU+tr1bjxBgJ2sD8U13fhlyG8KYR6spzgL/+D\n\
WPPBfOzcJr56PJbRsMCilaOgWbfyvzMj1At0SJ2tDDI+ZP9lK6TAJFXJ5oFBB3pe\n\
1tPsBw6iALFW7O1IslWZpH5+KnNlO/Fe+AZr2XfD8IppqzMwJEKHs0YzP/V3zMOG\n\
nd5ukjJsLvyjmRUgbB0q78O7JuOLw9oxuPZZUz5mWwjbAoknP/WWuNufI/B04Se9\n\
8gkmTbaHOm/DsJnXTpKB7QuqVUiOruy9ABEBAAGJAR8EGAECAAkFAlWtCnwCGwwA\n\
CgkQbiSY6lY673U77QgAmn937kOSamlSaYevjvB6RrOb9FwgoruhVBwp4JJzl/8c\n\
Aq6R+xiax6B2pEib3heiXLMSJorvbIv/AkOlH1jD5xeZwFZgA3isKumiSOnoBrIk\n\
DSVrzQMaU6LAb29hcG2tpKtx+ljqBLi792WZBJyfVOyDM+yVfy5vhUaEA1oSOLMF\n\
V3pxgva7AnoMjPZggDq/EboI0TNNGEnFOr1VQC0b/uF2GXmn5sfTIyKKFMle9r/m\n\
rzxqu5AsmTCJBnD1g68t1Yt13D2+A29CC4AxOJuUIschv5xmvmkEvEntsbuK9zQI\n\
cEks2btCMFTT1Px+PFo5wFWGrhyIhHuX1p/IPudXmA==\n\
=x05x\n-----END PGP PUBLIC KEY BLOCK-----"
ENV GPG_PRIVATE_KEY "n/a"

ENV SHARE_DIR /var/backup/share
ENV FILE_NAME "*.tar.gz"

# Install GPG and AWSCLI
RUN yum update -y && \
    yum install -y \
      gnupg2 \
      python-setuptools \
    yum -y clean all && \
    easy_install pip && \
    pip install \
      awscli

# Configure config before being replaced by exec'd cmd.
COPY start.sh /
CMD ["/start.sh"]
