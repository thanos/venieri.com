# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-03-05 01:53
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import modelcluster.fields


class Migration(migrations.Migration):

    dependencies = [
        ('images', '0001_initial'),
        ('events', '0025_auto_20190305_0152'),
    ]

    operations = [
        migrations.CreateModel(
            name='ArtCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('icon', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to='images.CustomImage')),
            ],
            options={
                'verbose_name_plural': 'art categories',
            },
        ),
        migrations.AddField(
            model_name='artpage',
            name='categories',
            field=modelcluster.fields.ParentalManyToManyField(blank=True, to='events.EventCategory'),
        ),
    ]
