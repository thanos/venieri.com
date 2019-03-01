# Generated by Django 2.1.7 on 2019-02-27 04:29

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('images', '0001_initial'),
        ('events', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='eventpagegalleryimage',
            name='image',
            field=models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, related_name='+', to='images.CustomImage'),
            preserve_default=False,
        ),
    ]
