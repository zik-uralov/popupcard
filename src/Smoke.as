package
{
  import org.flintparticles.common.actions.Age;
  import org.flintparticles.common.actions.Fade;
  import org.flintparticles.common.actions.ScaleImage;
  import org.flintparticles.common.counters.Steady;
  import org.flintparticles.common.displayObjects.RadialDot;
  import org.flintparticles.common.initializers.Lifetime;
  import org.flintparticles.common.initializers.SharedImage;
  import org.flintparticles.twoD.actions.LinearDrag;
  import org.flintparticles.twoD.actions.Move;
  import org.flintparticles.twoD.actions.RandomDrift;
  import org.flintparticles.twoD.emitters.Emitter2D;
  import org.flintparticles.twoD.initializers.Velocity;
  import org.flintparticles.twoD.zones.DiscSectorZone;

  import flash.geom.Point;
  public class Smoke extends Emitter2D
  {
    public function Smoke()
    {
      counter = new Steady( 10 );
      
      addInitializer( new Lifetime( 11, 10 ) );
      addInitializer( new Velocity( new DiscSectorZone( new Point( 0, 0 ), 40, 10, -4 * Math.PI / 7, -3 * Math.PI / 7 ) ) );
      addInitializer( new SharedImage( new RadialDot( 9 ) ) );
      
      addAction( new Age( ) );
      addAction( new Move( ) );
      addAction( new LinearDrag( 0.01 ) );
      addAction( new ScaleImage( 1, 15 ) );
      addAction( new Fade( 0.5, 0 ) );
      addAction( new RandomDrift( 10, 15 ) );
    }
  }
}