# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-03-06 16:03
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('socialmedia', '0002_socialmediasettings'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='socialmediasettings',
            name='trip_advisor',
        ),
        migrations.RemoveField(
            model_name='socialmediasettings',
            name='youtube',
        ),
        migrations.AddField(
            model_name='socialmediasettings',
            name='access_token_key',
            field=models.CharField(default='', help_text='Your Twitter access_token_key', max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='socialmediasettings',
            name='access_token_secret',
            field=models.CharField(default='', help_text='Your Twitter access_token_secret', max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='socialmediasettings',
            name='consumer_key',
            field=models.CharField(default='', help_text='Your Twitter consumer_key', max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='socialmediasettings',
            name='consumer_secret',
            field=models.CharField(default='', help_text='Your Twitter consumer_secret', max_length=255),
            preserve_default=False,
        ),
    ]