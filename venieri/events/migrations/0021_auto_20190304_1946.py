# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-03-04 19:46
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0020_auto_20190304_1910'),
    ]

    operations = [
        migrations.AlterField(
            model_name='artpage',
            name='project',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='art', to='events.ProjectPage'),
        ),
    ]
