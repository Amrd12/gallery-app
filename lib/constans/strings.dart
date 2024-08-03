// api
import 'package:flutter/material.dart';

const baseurl = "https://api.pexels.com/v1/";
const CuratedPhotos = "curated";
const Search = "search";
// Storage
const dirTryFolder = "/storage/emulated/0/";
const dirFolder =
    "/storage/emulated/0/Android/data/com.example.gallaryapp/files/";
const folderName = 'gallaryapp';
// routs
const navigationRoute = "/";
const homeRoute = "/home";
const exploreRoute = "/explore";
const layoutRoute = "/layout";
//hive
const hivebox = "PhotosBox";
const searchBox = "searchbox";
//search
const Map<String, Widget> orientationIcons = {
  "": Icon(Icons.not_interested),
  "landscape": Icon(Icons.landscape),
  "portrait": Icon(Icons.portrait),
  "square": Icon(Icons.photo),
};
