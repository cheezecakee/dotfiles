interface IconProps {
  icon: string
  className?: string
}

export function Icon({ icon, className = "" }: IconProps) {
  return <icon icon={icon} cssClasses={[className]} />
}
