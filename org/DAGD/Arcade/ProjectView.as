﻿﻿
package org.DAGD.Arcade {

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.display3D.IndexBuffer3D;

	public class ProjectView extends MainView {

		private var content: Sprite = new Sprite();
		public static const IMG_CONTAINER_WIDTH: int = 1176;
		public static const IMG_CONTAINER_HEIGHT: int = 520;
		public static const LEFT_MARGIN: int = 60;
		public static const TOP_MARGIN: int = 232;
		public static const BWIDTH: int = 30;
		public static const BHEIGHT: int = 30;
		private var backButton: Sprite = new Sprite();
		private var backButtonHitBox: Sprite = new Sprite();

		private var imgH: Number = 0;
		private var imgContainer: Sprite = new Sprite();
		
		private var projImgsMax:int;
		private var projImgsMin:int=0;
		private var projImgsCurrent:int=0;
		private var projImgsArray:Array = new Array();
		

		public function ProjectView(data: MediaModel) {
			// load image and add  
			// create text box and add 
			loadImage(data.mainPic);

			addChild(content);
			setupDesc(data.desc);
			setupTitle(data.title);
			projImgsMax = data.pics.length;
			for each(var imgs: String in data.pics){
				projImgsArray.push(imgs);
			}
		}
		public function changeImage(imgURL):void{
			loadImage(imgURL);
		}
		private function loadImage(imgURL): void {
			var request: URLRequest = new URLRequest(imgURL);
			var loader: Loader = new Loader();

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaded);
			loader.load(request);
		}
		private function handleLoaded(e: Event): void {
			imgContainer.graphics.beginFill(0x0);
			imgContainer.graphics.drawRect(0, 0, IMG_CONTAINER_WIDTH, IMG_CONTAINER_HEIGHT);

			e.target.removeEventListener(Event.COMPLETE, handleLoaded);
			var img: Bitmap = e.target.content;

			//img.scaleX=2.56; 
			//img.scaleY=2.42; 

			imgContainer.x = LEFT_MARGIN;
			imgContainer.y = TOP_MARGIN;
			img.height = IMG_CONTAINER_HEIGHT;
			img.width = IMG_CONTAINER_WIDTH;
			img.x = LEFT_MARGIN;
			img.y = TOP_MARGIN;
			imgH = img.height;

			addChildAt(imgContainer, 0);
			content.addChild(img);
			createBackButton();

		}
		private function setupDesc(caption: String): void {

			var description: TextField = new TextField();
			description.multiline = true;
			description.wordWrap = true;
			description.selectable = false;
			description.autoSize = TextFieldAutoSize.LEFT;
			description.defaultTextFormat = new TextFormat("Arial", 18, 0xffffff);
			description.text = caption;
			description.antiAliasType = AntiAliasType.NORMAL;
			//description.height = IMG_CONTAINER_HEIGHT; 
			description.width = IMG_CONTAINER_WIDTH;
			description.x = LEFT_MARGIN;
			description.y = IMG_CONTAINER_HEIGHT + TOP_MARGIN + 20;

			addChild(description);

		}
		private function setupTitle(caption: String): void {

			var description: TextField = new TextField();
			description.multiline = false;
			description.wordWrap = false;
			description.selectable = false;
			description.autoSize = TextFieldAutoSize.LEFT;
			description.defaultTextFormat = new TextFormat("Arial", 48, 0xebb83e);
			description.text = caption;
			description.antiAliasType = AntiAliasType.NORMAL;
			//description.height = IMG_CONTAINER_HEIGHT; 
			description.width = IMG_CONTAINER_WIDTH;
			description.x = LEFT_MARGIN;
			description.y = 175;

			addChild(description);

		}
		private function createBackButton(): void {
			addChildAt(backButton, 1);
			backButton.graphics.beginFill(0xff0000);
			backButton.graphics.drawRect(0, 0, BWIDTH, BHEIGHT);
			backButton.addEventListener(MouseEvent.CLICK, goBack)
			
			/*
			var description: TextField = new TextField();
			description.multiline = false;
			description.wordWrap = false;
			description.selectable = false;
			description.autoSize = TextFieldAutoSize.LEFT;
			description.defaultTextFormat = new TextFormat("Arial", 36, 0xebb83e);
			description.text = "x";
			description.antiAliasType = AntiAliasType.NORMAL;
			description.height = 1; 
			description.width = 1;
			description.x = backButton.x+5;
			description.y = backButton.y-10;
			addChild(description);
			
			backButtonHitBox.graphics.drawRect(0, 0, BWIDTH, BHEIGHT);
			backButtonHitBox.addEventListener(MouseEvent.CLICK, goBack);
			
			//backButtonHitBox.x =backButton.x;
			//backButtonHitBox.y =backButton.y;
			//addChild(backButtonHitBox);*/
		}
		public function ProjESC():void{
			ArcadeOS.goBackToTitle();
		}
		private function goBack(e:Event):void{
			ProjESC();
		}
			
	}
}