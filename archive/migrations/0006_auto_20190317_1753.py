# Generated by Django 2.1.7 on 2019-03-17 17:53

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('archive', '0005_media_video'),
    ]

    operations = [
        migrations.RenameField(
            model_name='media',
            old_name='video',
            new_name='video_url',
        ),
    ]
