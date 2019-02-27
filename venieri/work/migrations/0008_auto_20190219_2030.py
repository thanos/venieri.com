# Generated by Django 2.1.7 on 2019-02-19 20:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('work', '0007_event_start_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='event',
            name='visible',
        ),
        migrations.RemoveField(
            model_name='project',
            name='slug',
        ),
        migrations.RemoveField(
            model_name='project',
            name='title',
        ),
        migrations.AddField(
            model_name='video',
            name='visible',
            field=models.BooleanField(default=True),
        ),
    ]
