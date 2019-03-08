# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-03-05 19:56
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('contenttypes', '0002_remove_content_type_name'),
    ]

    operations = [
        migrations.CreateModel(
            name='Account',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=128)),
            ],
            options={
                'manager_inheritance_from_future': True,
            },
        ),
        migrations.CreateModel(
            name='FacebookAccount',
            fields=[
                ('account_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='socialmedia.Account')),
                ('access_token', models.CharField(max_length=256)),
            ],
            options={
                'manager_inheritance_from_future': True,
            },
            bases=('socialmedia.account',),
        ),
        migrations.CreateModel(
            name='InstagramAccount',
            fields=[
                ('account_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='socialmedia.Account')),
                ('user_name', models.CharField(max_length=128)),
                ('user_password', models.CharField(max_length=128)),
            ],
            options={
                'manager_inheritance_from_future': True,
            },
            bases=('socialmedia.account',),
        ),
        migrations.CreateModel(
            name='PintrestAccount',
            fields=[
                ('account_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='socialmedia.Account')),
                ('username_or_email', models.CharField(max_length=128)),
                ('user_password', models.CharField(max_length=128)),
                ('board_id', models.CharField(max_length=128)),
            ],
            options={
                'manager_inheritance_from_future': True,
            },
            bases=('socialmedia.account',),
        ),
        migrations.CreateModel(
            name='TwitterAccount',
            fields=[
                ('account_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='socialmedia.Account')),
                ('consumer_key', models.CharField(max_length=128)),
                ('consumer_secret', models.CharField(max_length=128)),
                ('access_token_key', models.CharField(max_length=128)),
                ('access_token_secret', models.CharField(max_length=128)),
            ],
            options={
                'manager_inheritance_from_future': True,
            },
            bases=('socialmedia.account',),
        ),
        migrations.AddField(
            model_name='account',
            name='polymorphic_ctype',
            field=models.ForeignKey(editable=False, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='polymorphic_socialmedia.account_set+', to='contenttypes.ContentType'),
        ),
    ]
