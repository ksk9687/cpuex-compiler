val off : bool ref
val noeffectfun : S.t
val effect : S.t -> KNormal.t -> bool
val effect_fun : Id.t -> S.t -> KNormal.t -> bool
val f : KNormal.t -> KNormal.t
