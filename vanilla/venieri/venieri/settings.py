"""
Django settings for venieri project.

Generated by 'django-admin startproject' using Django 2.1.7.

For more information on this file, see
https://docs.djangoproject.com/en/2.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/2.1/ref/settings/
"""

import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/2.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'h9$k1%4)6c^65!3@ds*cyo4icj!1#bxq&ukajp=s@phga@as2@'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1' ,'testserver']

APPEND_SLASH=True #False



# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',

    'django.contrib.messages',
    'whitenoise.runserver_nostatic',
    'django.contrib.staticfiles',
    'django.contrib.sitemaps',
    'django.contrib.sites',
] + [
    'sortedm2m',
    'embed_video',
    'versatileimagefield',
    'django_extensions',
    'codemirror2',
    'whitenoise',
    'bakery',
    # 'django_medusa',
    # 'django_distill',
    'meta',
    'django_json_ld',
    ] + [
    'venieri',
    'archive',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'venieri.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [ os.path.join(BASE_DIR, 'templates'),],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [

                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'venieri.wsgi.application'


# Database
# https://docs.djangoproject.com/en/2.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}


# Password validation
# https://docs.djangoproject.com/en/2.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/2.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True

DATE_INPUT_FORMATS = [
    '%Y-%m-%d', '%m/%d/%Y', '%m/%d/%y', # '2006-10-25', '10/25/2006', '10/25/06'
    '%b %d %Y', '%b %d, %Y',            # 'Oct 25 2006', 'Oct 25, 2006'
    '%d %b %Y', '%d %b, %Y',            # '25 Oct 2006', '25 Oct, 2006'
    '%B %d %Y', '%B %d, %Y',            # 'October 25 2006', 'October 25, 2006'
    '%d %B %Y', '%d %B, %Y',            # '25 October 2006', '25 October, 2006'
]


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.1/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
print(STATIC_ROOT)
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.1/howto/static-files/



MEDIA_URL = '/media/'
MEDIA_ROOT= os.path.join(BASE_DIR, 'media')


ARCHIVE_VIDEO_THUMBNAIL=(100,100)
ARCHIVE_IMAGE_THUMBNAIL=(75,75)

SERIALIZATION_MODULES = {
    'xml':    'tagulous.serializers.xml_serializer',
    'json':   'tagulous.serializers.json',
    'python': 'tagulous.serializers.python',
    'yaml':   'tagulous.serializers.pyyaml',
}


#
# Meta
#
META_USE_SITES=True
META_SITE_PROTOCOL='http'
META_USE_OG_PROPERTIES=True
META_USE_TWITTER_PROPERTIES=True
META_USE_GOOGLEPLUS_PROPERTIES=True

SITE_ID=1


VIRTUAL_WORLD='http://venieri.com/venieri/Virtual_World.html'


BUILD_DIR = os.path.join(BASE_DIR, '..', 'www')

BAKERY_VIEWS = (
                    'archive.views.EventPagedView',
                    'archive.views.EventDetailView',
                    'archive.views.BioView',
                    'archive.views.VirtualWorldView',
                    'archive.views.ProjectListView',
                    'archive.views.ProjectDetailView',
                    'archive.views.ArtListView',
                    'archive.views.ArtDetailView',
                    'archive.sitemaps.BuildableSitemapView',
                )


#
# Medusa
# https://github.com/alsoicode/django-medusa
#
MEDUSA_RENDERER_CLASS = "django_medusa.renderers.DiskStaticSiteRenderer"
MEDUSA_MULTITHREAD = False
MEDUSA_DEPLOY_DIR = os.path.abspath(os.path.join(BASE_DIR,'website'))
MEDUSA_COLLECT_STATIC = True
MEDUSA_COLLECT_STATIC_IGNORE = ['admin', 'less']

#JSON_LD_EMPTY_INPUT_RENDERING='generate_thing'

DISTILL_DIR=os.path.abspath(os.path.join(BASE_DIR,'static-site'))
FREEZE_ROOT = '/...'

STATIC_SITE = True if os.environ.get('STATIC_SITE') else False