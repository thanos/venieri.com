# Generated by Django 2.1.7 on 2019-02-23 15:02

from django.db import migrations
import versatileimagefield.fields
import work.models


class Migration(migrations.Migration):

    dependencies = [
        ('work', '0021_media'),
    ]

    operations = [
        migrations.AlterField(
            model_name='media',
            name='image',
            field=versatileimagefield.fields.VersatileImageField(blank=True, null=True, upload_to=work.models.image_path),
        ),
    ]
