//AS3ExporterAIR version 2.3, code Flash 10, generated by Prefab3D: http://www.closier.nl/prefab
package 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.materials.*;
	import away3d.core.base.*;
	import away3d.core.utils.Init;
	import away3d.loaders.utils.*;
	import away3d.loaders.data.*;
	import flash.utils.Dictionary;
	import away3d.primitives.*;

	import flash.geom.*;

	public class Gun extends Mesh
	{
		private var objs:Object = {};
		private var geos:Array = [];
		private var oList:Array =[];
		private var aC:Array;
		private var aV:Array;
		private var aU:Array;
		private var _scale:Number;

		public function Gun(init:Object = null)
		{
			var ini:Init = Init.parse(init);
			_scale = ini.getNumber("scaling", 2.5);
			setSource();
			addContainers();
			buildMeshes();
			buildMaterials();
			cleanUp();
		}

		private function buildMeshes():void
		{
			var m0:Matrix3D = new Matrix3D();
			m0.rawData = Vector.<Number>([1,0,0,0,0,1,0,0,0,0,1,0,-0.0010104179382324219*_scale,75.45960664749146*_scale,-21.549309074878693*_scale,1]);
			transform = m0;

			objs.obj0 = {name:"mesh15",  transform:m0, pivotPoint:new Vector3D(0,0,0), container:-1, bothsides:false, material:null, ownCanvas:false, pushfront:false, pushback:false};
			objs.obj0.geo=geos[0];

			var ref:Object;
			
			var j:int;
			var av:Array;
			var au:Array;
			var v0:Vertex;
			var v1:Vertex;
			var v2:Vertex;
			var u0:UV;
			var u1:UV;
			var u2:UV;
			var aRef:Array ;
			for(var i:int = 0;i<1;++i){
				ref = objs["obj"+i];
				if(ref != null){
					this.type = ".as";
					this.bothsides = ref.bothsides;
					this.name = ref.name;
					this.pushfront = ref.pushfront;
					this.pushback = ref.pushback;
					this.ownCanvas = ref.ownCanvas;

					oList.push(this);
					this.transform = ref.transform;
					this.movePivot(ref.pivotPoint.x, ref.pivotPoint.y, ref.pivotPoint.z);
					if (ref.geo.geometry != null) {
						this.geometry = ref.geo.geometry;
						continue;
					}
					ref.geo.geometry = new Geometry();
					this.geometry = ref.geo.geometry;
					aRef = ref.geo.f.split(",");
					for(j = 0;j<aRef.length;j+=6){
						try{
							av = ref.geo.aV[parseInt(aRef[j], 16)].split("/");
							v0 = new Vertex(Number(parseFloat(av[0]))*_scale, Number(parseFloat(av[1]))*_scale, Number(parseFloat(av[2]))*_scale);
							av = ref.geo.aV[parseInt(aRef[j+1],16)].split("/");
							v1 = new Vertex(Number(parseFloat(av[0]))*_scale, Number(parseFloat(av[1]))*_scale, Number(parseFloat(av[2]))*_scale);
							av = ref.geo.aV[parseInt(aRef[j+2],16)].split("/");
							v2 = new Vertex(Number(parseFloat(av[0]))*_scale, Number(parseFloat(av[1]))*_scale, Number(parseFloat(av[2]))*_scale);
							au = ref.geo.aU[parseInt(aRef[j+3],16)].split("/");
							u0 = new UV(parseFloat(au[0]), parseFloat(au[1]));
							au = ref.geo.aU[parseInt(aRef[j+4],16)].split("/");
							u1 = new UV(parseFloat(au[0]), parseFloat(au[1]));
							au = ref.geo.aU[parseInt(aRef[j+5],16)].split("/");
							u2 = new UV(parseFloat(au[0]), parseFloat(au[1]));
							ref.geo.geometry.addFace( new Face(v0, v1, v2, ref.material, u0, u1, u2) );
						}catch(e:Error){
							trace("obj"+i+": ["+aV[parseInt(aRef[j],16)].split("/")+"],["+aV[parseInt(aRef[j+1],16)].split("/")+"],["+aV[parseInt(aRef[j+2],16)].split("/")+"]");
							trace("     uvs: ["+aV[parseInt(aRef[j+3],16)].split("/")+"],["+aV[parseInt(aRef[j+4],16)].split("/")+"],["+aU[parseInt(aRef[j+5],16)].split("/")+"]");
						}
					}
				}
			}
		}

		private function setSource():void
		{
			var geo0:Object = {};
			geo0.aVstr="5.1f62/26.1fac/1.1567,8.d60/24.212a/-1.215b,8.19b2/b.1176/-0.5f6,0.0000/25.1393/-0.1684,5.21e3/c.026b/3.17d5,0.0001/c.6c1/5.ee9,0.0000/28.0394/3.820,6.0314/-11.1553/4.22e7,0.0000/-13.1a69/2.21f8,0.0000/-12.11ed/6.1b2d,d.1ff2/-a.0003/-7.2322,9.1da1/f.d07/-8.157a,7.1c45/a.0193/-e.23dc,c.e57/-a.20b6/-e.1566,0.0001/e.236c/-7.9a4,0.0001/9.a0c/-10.1fce,0.0001/-a.243c/-10.c85,d.1013/-28.2218/-7.481,c.bd6/-27.127e/-e.1227,0.0001/-26.2597/-10.4d0,8.1afc/-12.18de/0.1d1b,0.0001/b.1176/1.f7d,0.0001/-a.0003/-6.18e7,0.0001/-28.1406/-5.1ebb,0.0000/3b.1206/-3.1014,4.1e31/3a.0239/-6.1210,4.2672/1d.f37/-5.bad,0.0000/1f.1010/-2.03d0,0.0000/38.1c5d/-9.232c,0.0000/1b.26c9/-8.1f86,6.0310/21.c44/-2.155b,7.bee/1f.e28/-5.1b22,7.142f/2.261d/-4.14bf,6.0310/4.1bfe/-1.ce2,6.0310/1d.22fe/-9.a02,6.0310/1.ba8/-8.0189,0.0001/5.76a/-0.8a8,0.0000/21.c44/-1.1121,0.0000/1d.22fe/-a.20f5,0.0001/0.111b/-9.187c,0.0001/2.261d/-4.14bf,0.0000/1f.e28/-5.1b22,6.0310/4e.1630/-4.f91,7.bee/51.12eb/-7.1558,7.142f/39.1843/-6.ef5,6.0310/3b.e24/-3.718,6.0310/54.1524/-b.437,6.0310/37.24de/-9.22ce,0.0000/3b.20a0/-2.02dd,0.0000/4d.1c13/-3.b57,0.0000/56.400/-c.1b2b,0.0000/37.0341/-b.12b2,0.0000/39.1843/-6.ef5,0.0000/51.12eb/-7.1558,6.0311/-47.26ff/13.2645,a.14e9/-35.ae1/-6.1dd1,8.0366/-41.c57/-6.154f,3.105d/-4e.1aae/14.9ce,-0.0001/-56.400/15.0194,-0.0000/-46.0029/14.1e0b,-0.0000/-49.92e/-5.401,-0.0001/-33.c25/-5.c84,9.1da1/-51.0383/-5.13a8,e.1d10/-28.23ee/-6.d0d,7.1c45/-49.2088/-12.0242,c.e57/-26.169f/-13.706,-0.0001/-53.235e/-4.8ef,-0.0000/-49.686/-13.26fe,0.0000/-25.1e38/-15.0194,0.0001/-28.13d5/-5.43c,5.89f/-10.551/2.1877,7.ce2/-10.1fa7/0.1ee0,7.982/-2d.1f86/2.738,5.89f/-2e.133f/4.8b2,5.89f/-11.8a9/-1.a32,5.89f/-2d.190a/-0.932,3.45d/-10.1fa6/0.1ee0,3.7bc/-2d.1f86/2.738,b.1139/-6.1d86/-8.020a,c.4b3/-17.22ee/-7.1640,9.98a/-13.1742/-0.5ff,9.c0b/-3.156b/-0.1aca,0.0000/-18.229e/-7.0a3,0.0000/-14.03aa/1.14d6,0.0001/-3.1550/1.037c,0.0001/-6.25f6/-7.4ef,9.23d9/-2c.10a4/-2.fe0,9.ec3/-38.1689/-1.2415,7.26b1/-3d.25a9/5.133b,7.1c48/-2e.f84/4.2581,-0.0000/-35.794/-2.2239,-0.0000/-3c.dba/7.701,-0.0000/-2e.f6a/6.1cb6,0.0000/-2b.1ff5/-2.1ef1,-5.1f62/26.1fac/1.1567,-8.19b2/b.1176/-0.5f6,-8.d60/24.212a/-1.215b,-5.21e3/c.026b/3.17d6,-6.0314/-11.1553/4.22e7,-d.1ff2/-a.0003/-7.2322,-7.1c45/a.0193/-e.23dc,-9.1da0/f.d07/-8.157a,-c.e57/-a.20b6/-e.1566,-d.1013/-28.1f5e/-7.481,-c.bd6/-27.1526/-e.1227,-8.1afc/-12.18de/0.1d1b,-4.2672/1d.f37/-5.bad,-4.1e30/3a.0239/-6.1210,-6.0310/21.c44/-2.155b,-7.142e/2.261d/-4.14bf,-7.bed/1f.e28/-5.1b22,-6.0310/4.1bfe/-1.ce2,-6.0310/1d.22fe/-9.a02,-6.0310/1.ba8/-8.0189,-6.0310/4e.1630/-4.f91,-7.142e/39.1843/-6.ef5,-7.bed/51.12eb/-7.1558,-6.0310/3b.e24/-3.718,-6.0310/54.1524/-b.437,-6.0310/37.24de/-9.22ce,-6.0311/-47.26ff/13.2645,-8.0366/-41.c57/-6.154f,-a.14e9/-35.ae1/-6.1dd1,-3.105d/-4e.1aae/14.9ce,-9.1da1/-51.0383/-5.13a8,-7.1c45/-49.2088/-12.0242,-e.1d10/-28.23ee/-6.d0d,-c.e57/-26.169f/-13.706,-5.89f/-10.551/2.1877,-7.982/-2d.1f86/2.738,-7.ce1/-10.1fa7/0.1ee0,-5.89f/-2e.133f/4.8b3,-5.89f/-11.8a9/-1.a32,-5.89f/-2d.190a/-0.932,-3.45d/-10.1fa6/0.1ee0,-3.7bc/-2d.1f86/2.738,-b.1139/-6.1d86/-8.020a,-9.98a/-13.1742/-0.5ff,-c.4b3/-17.22ee/-7.1640,-9.c0b/-3.156b/-0.1aca,-9.23d9/-2c.10a4/-2.fe0,-7.26b1/-3d.25a9/5.133b,-9.ec3/-38.1689/-1.2415,-7.1c48/-2e.f84/4.2581";
			geo0.aUstr="0.002fc4276442680/0.13d263ed90433f,0.001cd04e1b6d48b4/0.12f2fd6cf74f37,0.45b17c66752dcc/0.12ad299600e71a,0.744dfeeab55e/0.12df85a26e023d,0.04c1a2857951258/0.12f2fd6cf74f37,0.0b828283597fa6/0.13d263ed90433f,0.177691a60fc059/0.12c05bd971bf5f,0.17a2382ea490e1/0.111c90341879eb,0.a2528d822c2be0/0.1de95462ba975,0.103ba682c957f1/0.111ed50eed380d,0.5124f15d27a04/0.13d26051dba3e6,0.25d059728aacd/0.111c90341879eb,0.103b7445f685ea/0.1de95462ba975,0.a11fcb45473fb8/0.f39034ec54a75,0.18e69d6b67c362/0.f485d26777724,0.18dd3418c896a2/0.125dec01d67aee,0.101a1e20afaaf8/0.125de790f82cf6,0.95f45f98dcd510/0.4dde4785636e40,0.e5e987ab8506/0.2a8224dbf8bc40,0.90b7286a92961/0.4f40594053f53c,0.95a0f311c84620/0.29f1cc2070f500,0.16dd6791ad47/0.62bf6af3341f44,0.4dfb6703fe9734/0.917fd76e80c2f0,0.117ec354946c60/0.eca2fc4376824,0.137e0aa5301793/0.630d541b4d829c,0.45bb2f7bc0b190/0.13d26051dba3e6,0.001cabc3d3dfb992/0.12d455d06f59d3,0.260474553e305/0.1d0e30d0f424ea,0.198207a64046a9/0.1af0fe6b6e0a5d,0.c8e506a5de265/0.1b19280e69be35,0.c4b7b99e3a508/0.1d4dafbaf56241,0.169bc17c18764e/0.14f5f107b07f2e,0.16cf25a0a9be2c/0.136f9ee04b86c5,0.bdedd946adb9c/0.13670d36d80467,0.752ae9f48bed20/0.35933c6361b0,0.4bf21a0b71ee80/0.129475c16f32e8,0.4bfbcd20bd7244/0.13b9ac7d49efb4,0.5a51e52044b12/0.13b9b018fe8f0d,0.4c08721f34a288/0.13c0787c87a506,0.e697025e0a04c/0.4dce78c21464c8,0.fa969ede4c9b3/0.43265010ee1d6c,0.b5584467c271/0.6bf3fd83476a9,0.7639473395ddd/0.4cd254643781e8,0.2d09b80e20f818/0.3a4a61a1197a50,0.308b0e6204ae6a/0.77c46067a2e77,0.01a3fa26452c6c8/0.4a32defd3b0a40,0.018b5e3db0f63a1/0.3b9a1cd9d1c348,0.9637ef7beba6e0/0.5376ca2541fc50,0.a1309a142788a0/0.6968e941b5a8ec,0.101f6e14dcf7d4/0.5376ee3a5035d0,0.1020b1d9ac5c46/0.5332f641e72098,0.dae045c743aa/0.1d5a9e6a557052,0.537db22cfafdd0/0.133d42b0577933,0.bcffc55cda447/0.1334b12a6ae945,0.77a99880065590/0.2ee9e7f58b5ca,0.110084f2415ae6/0.2a625b19144caa,0.01c37f588959347/0.2a57f1b20223e4,0.01a92815db96073/0.91320cce5fb7a,0.a7b94ba13fc380/0.5901c6431072b8,0.1692cef4b3ef3c/0.2287c913bd399a,0.169ce28f1f199d/0.21be370569ba8c,0.1e5e4aaf2e4b98/0.21ccbdfd9fe8e8,0.30968d83c58f5/0.22858427250240,0.76f5bd0da2afa/0.bf1afab8d6b5c,0.001c96a8617f13a7/0.bf0402fb1b768,0.002043da88634224/0.ef505c94653c6,0.4a743426f03fd0/0.ef501586805ce,0.f52c521626af0/0.55c538124a587,0.5db9ccf796f618/0.36fd546d8da028,0.98e846c6c39e70/0.0b0d3cac4c115a0,0.5d168cb3fb4ea8/0.0123f1fdcc9b81f";
			geo0.aV= read(geo0.aVstr).split(",");
			geo0.aU= read(geo0.aUstr).split(",");
			geo0.f="0,1,2,0,1,2,3,1,0,3,4,5,4,5,0,6,7,8,0,5,6,8,7,9,7,8,9,5,3,a,5,4,7,b,6,c,5,7,9,b,c,9,a,b,c,d,e,f,a,c,d,d,f,10,c,e,f,11,12,13,b,e,c,14,12,11,10,d,c,15,16,17,10,c,f,15,17,18,11,a,12,e,d,f,12,a,d,f,d,10,d,10,12,16,15,17,12,10,13,17,15,18,3,0,6,3,5,a,2,7,4,2,0,19,0,2,4,0,2,19,2,14,7,2,1a,0,7,14,8,5,4,3,3,15,2,0,19,2,2,1,3,2,1,0,15,8,14,19,0,1,14,2,15,1,2,19,16,e,b,10,f,e,b,a,16,e,d,10,17,16,a,f,10,d,a,11,17,d,e,f,18,19,1a,1b,1c,1d,18,1a,1b,1b,1d,1e,19,1c,1a,1c,1b,1d,1a,1c,1d,1d,1b,1e,1e,1f,20,1f,20,21,1e,20,21,1f,21,22,1f,22,20,20,1f,21,20,22,23,21,1f,22,24,25,1e,21,20,1f,1e,21,24,1f,22,21,26,27,23,20,21,22,23,22,26,22,1f,20,28,24,21,21,22,22,21,20,28,22,21,21,27,28,20,22,21,21,20,23,27,21,22,22,25,29,1f,23,24,25,1f,1e,25,25,26,23,29,26,22,23,24,25,22,1f,29,25,26,23,2a,2b,2c,27,28,29,2a,2c,2d,27,29,2a,2b,2e,2c,28,27,29,2c,2e,2f,29,27,2a,30,31,2a,29,28,27,2a,2d,30,27,2a,29,32,33,2f,28,29,2a,2f,2e,32,2a,27,28,34,30,2d,2b,2c,2d,2d,2c,34,2d,2e,2b,33,34,2c,2c,2b,2e,2c,2f,33,2e,2d,2c,2a,35,2b,2f,30,31,35,2a,31,30,2f,32,35,32,2e,30,31,2f,2e,2b,35,2f,32,30,36,37,38,33,34,35,36,38,39,33,35,36,3a,3b,36,21,20,1f,36,39,3a,1f,22,21,3c,3a,39,34,33,36,39,38,3c,36,35,34,3b,3d,37,37,38,39,37,36,3b,39,3a,37,3e,3f,40,e,d,f,40,3f,41,f,d,10,42,40,43,12,11,13,42,3e,40,12,14,11,41,44,40,16,15,17,40,44,43,17,15,18,42,45,3e,f,10,e,3f,3e,45,d,e,10,44,41,3f,12,14,11,3f,45,44,11,13,12,46,47,48,3b,3c,3d,46,48,49,3b,3d,3e,47,4a,48,3c,3b,3d,48,4a,4b,3d,3b,3e,4c,46,4d,3c,3b,3d,4d,46,49,3d,3b,3e,4a,4c,4d,3b,3c,3d,4a,4d,4b,3b,3d,3e,4e,4f,50,3f,40,41,4e,50,51,3f,41,42,4f,52,50,43,44,45,52,53,50,44,46,45,54,51,50,3f,42,41,54,50,53,3f,41,40,55,4e,51,44,43,45,51,54,55,45,46,44,56,57,58,3f,40,41,56,58,59,3f,41,42,57,5a,58,43,44,45,5a,5b,58,44,46,45,5c,59,58,3f,42,41,5c,58,5b,3f,41,40,5d,56,59,44,43,45,59,5c,5d,45,46,44,5d,5a,57,f,10,d,57,56,5d,d,e,f,5e,5f,60,0,2,1,3,5e,60,3,5,4,61,5e,5,6,8,7,5e,6,5,8,9,7,62,9,8,5,a,3,5,62,61,b,c,6,5,9,62,b,9,c,63,64,65,d,f,e,63,66,64,d,10,f,64,f,e,11,13,12,65,64,e,14,11,12,10,64,66,15,17,16,10,f,64,15,18,17,67,68,63,e,f,d,68,66,63,f,10,d,66,68,10,16,17,15,68,13,10,17,18,15,3,6,5e,3,a,5,5f,61,62,2,19,0,5e,61,5f,0,19,2,5f,62,69,2,0,1a,62,8,69,5,3,4,3,5f,15,0,2,19,5f,3,60,2,0,1,15,69,8,19,1,0,69,15,5f,1,19,2,16,65,e,10,e,f,65,16,63,e,10,d,17,63,16,f,d,10,63,17,67,d,f,e,18,6a,6b,1b,1d,1c,18,1b,6a,1b,1e,1d,6b,6a,1c,1c,1d,1b,6a,1d,1c,1d,1e,1b,6c,6d,6e,1f,21,20,6c,6f,6d,1f,22,21,6e,6d,70,20,21,1f,6d,71,70,21,22,1f,24,6c,25,21,1f,20,6c,24,6f,1f,21,22,26,71,27,20,22,21,71,26,70,22,20,1f,28,6f,24,21,22,22,6f,28,6d,22,21,21,27,6d,28,22,21,21,6d,27,71,21,22,22,25,6e,29,23,25,24,6e,25,6c,25,23,26,29,70,26,23,25,24,70,29,6e,25,23,26,72,73,74,27,29,28,72,75,73,27,2a,29,74,73,76,28,29,27,73,77,76,29,2a,27,30,72,31,29,27,28,72,30,75,27,29,2a,32,77,33,28,2a,29,77,32,76,2a,28,27,34,75,30,2b,2d,2c,75,34,73,2d,2b,2e,33,73,34,2c,2e,2b,73,33,77,2e,2c,2d,72,74,35,2f,31,30,35,31,72,30,32,2f,35,76,32,30,2f,31,76,35,74,2f,30,32,78,79,7a,33,35,34,78,7b,79,33,36,35,3a,78,3b,21,1f,20,78,3a,7b,1f,21,22,3c,7b,3a,34,36,33,7b,3c,79,36,34,35,3b,7a,3d,37,39,38,7a,3b,78,39,37,3a,7c,7d,7e,e,f,d,7d,7f,7e,f,10,d,42,43,7d,12,13,11,42,7d,7c,12,11,14,7f,7d,44,16,17,15,7d,43,44,17,18,15,42,7c,45,f,e,10,7e,45,7c,d,10,e,44,7e,7f,12,11,14,7e,44,45,11,12,13,80,81,82,3b,3d,3c,80,83,81,3b,3e,3d,82,81,84,3c,3d,3b,81,85,84,3d,3e,3b,86,87,80,3c,3d,3b,87,83,80,3d,3e,3b,84,87,86,3b,3d,3c,84,85,87,3b,3e,3d,88,89,8a,3f,41,40,88,8b,89,3f,42,41,8a,89,52,43,45,44,52,89,53,44,45,46,54,89,8b,3f,41,42,54,53,89,3f,40,41,55,8b,88,44,45,43,8b,55,54,45,44,46,8c,8d,8e,3f,41,40,8c,8f,8d,3f,42,41,8e,8d,5a,43,45,44,5a,8d,5b,44,45,46,5c,8d,8f,3f,41,42,5c,5b,8d,3f,40,41,5d,8f,8c,44,45,43,8f,5d,5c,45,44,46,5d,8e,5a,f,d,10,8e,5d,8c,d,f,e";
			geos.push(geo0);
		}

		private function buildMaterials():void
		{
		}
		private function cleanUp():void
		{
			for(var i:int = 0;i<1;++i){
				objs["obj"+i] == null;
			}
			aV = null;
			aU = null;
		}

		private function addContainers():void
		{}


		public function get meshes():Array
		{
			return oList;
		}


		private function read(str:String):String
		{
			var start:int= 0;
			var chunk:String;
			var end:int= 0;
			var dec:String = "";
			var charcount:int = str.length;
			for(var i:int = 0;i<charcount;++i){
				if (str.charCodeAt(i)>=44 && str.charCodeAt(i)<= 48 ){
					dec+= str.substring(i, i+1);
				}else{
					start = i;
					chunk = "";
					while(str.charCodeAt(i)!=44 && str.charCodeAt(i)!= 45 && str.charCodeAt(i)!= 46 && str.charCodeAt(i)!= 47 && i<=charcount){
						i++;
					}
					chunk = ""+parseInt("0x"+str.substring(start, i), 16 );
					dec+= chunk;
					i--;
				}
			}
			return dec;
		}

	}
}