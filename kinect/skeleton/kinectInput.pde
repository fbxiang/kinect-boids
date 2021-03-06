class KinectInput extends Input{

  KinectPV2 kinect;
  
  
  float zVal = 300;
  float rotX = PI;
  
  KinectInput(PApplet _p) {
    kinect = new KinectPV2(_p);
  
    kinect.enableColorImg(true);
  
    //enable 3d  with (x,y,z) position
    kinect.enableSkeleton3DMap(true);
  
    kinect.init();
  }
  
  void collision(Boid b){
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
  
        boolean collides = b.checkCollision(joints, KinectPV2.JointType_HandTipLeft, KinectPV2.JointType_HandTipRight);
        if (collides) {
           sendCollisionMsg(b, joints[KinectPV2.JointType_HandTipLeft].getX(), joints[KinectPV2.JointType_HandTipLeft].getY(), joints[KinectPV2.JointType_HandTipRight].getX(), joints[KinectPV2.JointType_HandTipRight].getY());
        }
      }
    }
  }
  
   // test if the kinect is connected
  boolean kinected(){
    kinect.getColorImage();
    int[] raw = kinect.getRawColor();
    
    //test if we are receiving an image
    //I'm just checking the first 100 pixels for speed
    for(int i=0; i<100; i++){
      if(raw[i] != 0)
        return true;
    }
    return false;
  }
  
  void drawInput() {  
    pushMatrix();
    translate(width/2, height/2, 0);
    scale(zVal);
    rotateX(rotX);
  
    ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
  
    //individual JOINTS
    for (int i = 0; i < skeletonArray.size(); i++) {
      KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
      if (skeleton.isTracked()) {
        KJoint[] joints = skeleton.getJoints();
  
        //draw different color for each hand state
        //drawHandState(joints[KinectPV2.JointType_HandRight]);
        //drawHandState(joints[KinectPV2.JointType_HandLeft]);
  
        //Draw body
        color col  = skeleton.getIndexColor();
        stroke(col);
        drawBody(joints);
      }
    }
    
    popMatrix();
  }
  
  
  void drawBody(KJoint[] joints) {
    //drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
    //drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
    //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  
    //drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
    //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
    //drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
    //drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
    //drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);
  
    //// Right Arm    
    //drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
    //drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
    //drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
    //drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
    //drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);
  
    //// Left Arm
    //drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
    //drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
    //drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
    //drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
    //drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);
  
    //// Right Leg
    //drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
    //drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
    //drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);
  
    //// Left Leg
    //drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
    //drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
    //drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);
  
    drawJoint(joints, KinectPV2.JointType_HandTipLeft);
    drawJoint(joints, KinectPV2.JointType_HandTipRight);
    drawLine(joints, KinectPV2.JointType_HandTipLeft, KinectPV2.JointType_HandTipRight);
    //drawJoint(joints, KinectPV2.JointType_FootLeft);
    //drawJoint(joints, KinectPV2.JointType_FootRight);
  
    //drawJoint(joints, KinectPV2.JointType_ThumbLeft);
    //drawJoint(joints, KinectPV2.JointType_ThumbRight);
  
    //drawJoint(joints, KinectPV2.JointType_Head);
  }
  
  void drawJoint(KJoint[] joints, int jointType) {
    strokeWeight(2.0f + joints[jointType].getZ()*8);
    point(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  }
  
  void drawBone(KJoint[] joints, int jointType1, int jointType2) {
    strokeWeight(2.0f + joints[jointType1].getZ()*8);
    point(joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
  }
  
  void drawLine(KJoint[] joints, int jointType1, int jointType2) {
    strokeWeight(.01);
    stroke(255);
    line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType2].getX(), joints[jointType2].getY());
  }
  
  void drawHandState(KJoint joint) {
    handState(joint.getState());
    strokeWeight(5.0f + joint.getZ()*8);
    point(joint.getX(), joint.getY(), joint.getZ());
    
    
    PVector handLocCoord = convertToScreenCoord(joint.getX(), joint.getY(), joint.getZ());
    //PVector handLocCoord = new PVector(joint.getX(), joint.getY());
    //depending on hand state, attract or repel boids
    switch(joint.getState()) {
    case KinectPV2.HandState_Open:  
      //repulse
      //flock.handForce(handLocCoord, 1);
      break;
    case KinectPV2.HandState_Closed:
      //attract
      //flock.handForce(handLocCoord, -1);
      break;
    case KinectPV2.HandState_Lasso:
      //flock.addBoid(new Boid(width/2,height/2));
      break;
    }
  }
  
  void handState(int handState) {
    switch(handState) {
    case KinectPV2.HandState_Open:
      stroke(0, 255, 0);
      break;
    case KinectPV2.HandState_Closed:
      stroke(255, 0, 0);   
      break;
    case KinectPV2.HandState_Lasso:
      stroke(0, 0, 255);
      break;
    case KinectPV2.HandState_NotTracked:
      stroke(100, 100, 100);
      break;
    }
  }
  
  // kinect returns from -1, 1, need to convert to width and height
  PVector convertToScreenCoord(float x, float y, float z) {
    PVector result = new PVector(0.0, 0.0, 0.0);
    float tempWidth = (x+1)/2;
    float tempHeight = (y + 1)/2;
    
    result.x = tempWidth * width;
    result.y = (1 - tempHeight) * height;
    result.z = z;
    
    return result;
  }
}