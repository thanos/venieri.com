# Generated by Django 2.1.7 on 2019-02-19 20:26

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('work', '0006_event_poster'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='start_date',
            field=models.DateField(default=datetime.datetime(2019, 2, 19, 20, 26, 7, 888607, tzinfo=utc)),
            preserve_default=False,
        ),
    ]
