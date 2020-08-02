# Generated by Django 2.1.7 on 2019-03-18 14:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('archive', '0006_auto_20190317_1753'),
    ]

    operations = [
        migrations.AddField(
            model_name='entity',
            name='end_date',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='entity',
            name='html',
            field=models.TextField(blank=True, default=''),
        ),
        migrations.AddField(
            model_name='entity',
            name='start_date',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]